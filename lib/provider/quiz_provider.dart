import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loginsignup/data/dummy_data.dart';
import 'package:loginsignup/models/quiz_model.dart';

class QuizProvider with ChangeNotifier {
  final Box _quizBox = Hive.box('quiz_progress');

  String _selectedCategoryId = 'popular';
  String _searchText = '';
  List<Map<String, dynamic>> _allPlayedQuizzes = [];
  Timer? _expiryCheckTimer;

  String get selectedCategoryId => _selectedCategoryId;
  String get searchText => _searchText;
  List<Map<String, dynamic>> get allPlayedQuizzes => _allPlayedQuizzes;

  List<QuizSummary> get filteredQuizzes {
    return quizSummaries
        .where((q) =>
    q.categoryId == _selectedCategoryId &&
        q.title.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  Set<String> get ongoingQuizIds => Set<String>.from(
      (_quizBox.get('all_quizzes', defaultValue: {}) as Map).keys.cast<String>());

  Set<String> get playedQuizIds => Set<String>.from(
      (_quizBox.get('all_scores', defaultValue: {}) as Map).keys.cast<String>());

  QuizProvider() {
    _quizBox.listenable().addListener(refreshData);
    loadAllPlayedQuizzes();
    _startPeriodicExpiryCheck();
  }

  void refreshData() {
    loadAllPlayedQuizzes();
    notifyListeners();
  }

  void _startPeriodicExpiryCheck() {
    _expiryCheckTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _checkExpiredQuizzes();
    });
  }

  Future<void> _checkExpiredQuizzes() async {
    final all = Map<String, dynamic>.from(
        _quizBox.get('all_quizzes', defaultValue: {}) as Map);
    bool changed = false;

    for (var entry in all.entries) {
      final quizId = entry.key;
      final savedData = Map<String, dynamic>.from(entry.value);

      if (savedData['scoreAdded'] == true) continue;

      QuizDetail? quizDetail;
      try {
        quizDetail = quizDetails.firstWhere((q) => q.id == quizId);
      } catch (_) {
        continue;
      }

      if (savedData['startTime'] == null) continue;

      final startTime = DateTime.parse(savedData['startTime']);
      final durationMinutes = int.tryParse(
          quizDetail.duration.replaceAll(RegExp(r'[^0-9]'), '')) ??
          30;
      final expiry = startTime.add(Duration(minutes: durationMinutes));

      if (DateTime.now().isBefore(expiry)) continue;

      final selectedAnswers =
      Map<String, String>.from(savedData['selectedAnswers'] ?? {});
      int correctCount = 0;
      for (var q in quizDetail.questions) {
        if (selectedAnswers[q.id] == q.correctOptionId) correctCount++;
      }

      final allScores = Map<String, dynamic>.from(
          _quizBox.get('all_scores', defaultValue: {}) as Map);
      final scoreData = {
        'score': correctCount,
        'attempted': selectedAnswers.length,
        'total': quizDetail.totalQuestions,
        'date': DateTime.now().toIso8601String(),
      };

      if (!allScores.containsKey(quizId)) allScores[quizId] = [];
      allScores[quizId].add(scoreData);
      await _quizBox.put('all_scores', allScores);

      savedData['scoreAdded'] = true;
      all[quizId] = savedData;
      changed = true;
    }

    if (changed) {
      await _quizBox.put('all_quizzes', all);
      notifyListeners();
    }
  }

  void loadAllPlayedQuizzes() {
    final allSaved = Map<String, dynamic>.from(
        _quizBox.get('all_quizzes', defaultValue: {}) as Map);
    List<Map<String, dynamic>> loadedQuizzes = [];

    allSaved.forEach((quizId, savedData) {
      try {
        final quizDetail = quizDetails.firstWhere((q) => q.id == quizId);
        if (savedData['currentQuestionIndex'] < quizDetail.questions.length) {
          loadedQuizzes.add({
            'quizDetail': quizDetail,
            'currentQuestionIndex': savedData['currentQuestionIndex'] ?? 0,
            'selectedAnswers':
            Map<String, String>.from(savedData['selectedAnswers'] ?? {}),
            'startTime': savedData['startTime'],
          });
        }
      } catch (e) {
        debugPrint("Quiz not found for ID: $quizId");
      }
    });

    _allPlayedQuizzes = loadedQuizzes;
    notifyListeners();
  }

  void setSearchText(String value) {
    _searchText = value;
    if (value.isEmpty) {
      _selectedCategoryId = 'popular';
    } else {
      try {
        final matchingQuiz = quizSummaries.firstWhere(
                (q) => q.title.toLowerCase().contains(value.toLowerCase()));
        _selectedCategoryId = matchingQuiz.categoryId;
      } catch (_) {
        // No quiz found, do nothing
      }
    }
    notifyListeners();
  }

  void setSelectedCategory(String categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  String getQuizImage(String quizId) {
    try {
      final quiz = quizSummaries.firstWhere((q) => q.id == quizId);
      return quiz.imageAsset.isNotEmpty
          ? quiz.imageAsset
          : 'assets/placeholder.png';
    } catch (_) {
      return 'assets/placeholder.png';
    }
  }

  Future<void> removeQuiz(String quizId) async {
    final all = Map<String, dynamic>.from(
        _quizBox.get('all_quizzes', defaultValue: {}) as Map);

    if (all.containsKey(quizId)) {
      all.remove(quizId);
      await _quizBox.put('all_quizzes', all);

      // Manually trigger a refresh and notify listeners
      loadAllPlayedQuizzes();
    }
  }

  Future<void> startQuiz(QuizDetail quizDetail) async {
    final allQuizzes = Map<String, dynamic>.from(
        _quizBox.get('all_quizzes', defaultValue: {}) as Map);

    // Check if there's already progress for this quiz
    final existingData = allQuizzes[quizDetail.id];

    if (existingData == null || existingData['scoreAdded'] == true) {
      // If no data exists, or if the previous attempt was completed, start fresh
      final newQuizData = {
        'startTime': DateTime.now().toIso8601String(),
        'currentQuestionIndex': 0,
        'selectedAnswers': <String, String>{},
        'scoreAdded': false, // Explicitly set to false
      };
      allQuizzes[quizDetail.id] = newQuizData;
      await _quizBox.put('all_quizzes', allQuizzes);

      // Notify listeners that the state has changed (a new quiz is ongoing)
      notifyListeners();
    }
    // If a quiz is already ongoing (not completed), we do nothing and let the user continue it.
  }

  @override
  void dispose() {
    _expiryCheckTimer?.cancel();
    _quizBox.listenable().removeListener(refreshData);
    super.dispose();
  }
}
