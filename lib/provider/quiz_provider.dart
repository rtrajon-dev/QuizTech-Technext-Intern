import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loginsignup/models/quiz_model.dart';
import 'package:loginsignup/data/dummy_data.dart';


class QuizProvider with ChangeNotifier {
  final Box box = Hive.box('quiz_progress');
  Timer? _expiryTimer;

  List<Map<String, dynamic>> ongoingQuizzes = [];
  Map<String, dynamic> allScores = {};

  QuizProvider() {
    loadScores();
    _loadOngoingQuizzes();
    _startExpiryTimer();
    box.listenable().addListener(_onBoxChanged);
  }

  void _onBoxChanged() {
    _loadOngoingQuizzes();
    loadScores();
    notifyListeners();
  }

  void loadScores() {
    try {
      allScores =
      Map<String, dynamic>.from(box.get('all_scores', defaultValue: {}) as Map);
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading scores: $e");
    }
  }

  void _loadOngoingQuizzes() {
    try {
      final allQuizzes =
      Map<String, dynamic>.from(box.get('all_quizzes', defaultValue: {}) as Map);

      List<Map<String, dynamic>> loaded = [];

      allQuizzes.forEach((quizId, savedData) {
        try {
          final quizDetail = quizDetails.firstWhere((q) => q.id == quizId);

          if (savedData['startTime'] == null) {
            savedData['startTime'] = DateTime.now().toIso8601String();
            allQuizzes[quizId] = savedData;
            box.put('all_quizzes', allQuizzes);
          }

          if (savedData['currentQuestionIndex'] < quizDetail.questions.length) {
            loaded.add({
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

      ongoingQuizzes = loaded;
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading ongoing quizzes: $e");
    }
  }

  void _startExpiryTimer() {
    _expiryTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _checkExpiredQuizzes();
    });
  }

  Future<void> _checkExpiredQuizzes() async {
    try {
      final allQuizzes =
      Map<String, dynamic>.from(box.get('all_quizzes', defaultValue: {}) as Map);

      for (var entry in allQuizzes.entries) {
        final quizId = entry.key;
        final savedData = Map<String, dynamic>.from(entry.value);

        QuizDetail? quizDetail;
        try {
          quizDetail = quizDetails.firstWhere((q) => q.id == quizId);
        } catch (_) {
          continue;
        }

        if (savedData['startTime'] == null) continue;

        final startTime = DateTime.parse(savedData['startTime']);
        final durationMinutes =
            int.tryParse(quizDetail.duration.replaceAll(RegExp(r'[^0-9]'), '')) ??
                30;
        final expiry = startTime.add(Duration(minutes: durationMinutes));

        if (DateTime.now().isBefore(expiry)) continue;
        if (savedData['scoreAdded'] == true) continue;

        final selectedAnswers =
        Map<String, String>.from(savedData['selectedAnswers'] ?? {});
        int correctCount = 0;
        for (var q in quizDetail.questions) {
          if (selectedAnswers[q.id] == q.correctOptionId) correctCount++;
        }

        final allScoresLocal =
        Map<String, dynamic>.from(box.get('all_scores', defaultValue: {}) as Map);
        final scoreData = {
          'score': correctCount,
          'attempted': selectedAnswers.length,
          'total': quizDetail.totalQuestions,
          'date': DateTime.now().toIso8601String(),
        };
        if (!allScoresLocal.containsKey(quizId)) allScoresLocal[quizId] = [];
        allScoresLocal[quizId].add(scoreData);
        await box.put('all_scores', allScoresLocal);

        savedData['scoreAdded'] = true;
        allQuizzes[quizId] = savedData;
      }

      await box.put('all_quizzes', allQuizzes);
      _loadOngoingQuizzes();
    } catch (e) {
      debugPrint("Error checking expired quizzes: $e");
    }
  }


  Future<void> submitAutoScore(Map<String, dynamic> quizData) async {
    try {
      final box = Hive.box('quiz_progress');
      final QuizDetail quizDetail = quizData['quizDetail'];
      final selectedAnswers = Map<String, String>.from(quizData['selectedAnswers']);

      int correctCount = 0;
      for (var q in quizDetail.questions) {
        if (selectedAnswers[q.id] == q.correctOptionId) correctCount++;
      }

      final allScores = Map<String, dynamic>.from(box.get('all_scores', defaultValue: {}) as Map);
      final scoreData = {
        'score': correctCount,
        'attempted': selectedAnswers.length,
        'total': quizDetail.totalQuestions,
        'date': DateTime.now().toIso8601String(),
      };

      if (!allScores.containsKey(quizDetail.id)) {
        allScores[quizDetail.id] = [];
      }
      allScores[quizDetail.id].add(scoreData);
      await box.put('all_scores', allScores);

      // Mark as score added
      final allQuizzes = Map<String, dynamic>.from(box.get('all_quizzes', defaultValue: {}) as Map);
      final quizDataHive = allQuizzes[quizDetail.id];
      if (quizDataHive != null) {
        quizDataHive['scoreAdded'] = true;
        allQuizzes[quizDetail.id] = quizDataHive;
        await box.put('all_quizzes', allQuizzes);
      }
    } catch (e) {
      debugPrint('Error submitting auto score: $e');
    }
  }


  Future<void> removeQuiz(String quizId) async {
    try {
      final allQuizzes =
      Map<String, dynamic>.from(box.get('all_quizzes', defaultValue: {}) as Map);
      allQuizzes.remove(quizId);
      await box.put('all_quizzes', allQuizzes);
      _loadOngoingQuizzes();
    } catch (e) {
      debugPrint("Error removing quiz: $e");
    }
  }

  @override
  void dispose() {
    _expiryTimer?.cancel();
    super.dispose();
  }
}
