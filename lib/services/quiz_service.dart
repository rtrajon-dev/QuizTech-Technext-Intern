import 'package:hive_flutter/hive_flutter.dart';

class QuizService {
  final Box _box = Hive.box('quiz_progress');

  Map<String, dynamic> getAllScores() {
    final allScoresRaw = _box.get('all_scores');
    return (allScoresRaw is Map)
        ? Map<String, dynamic>.from(allScoresRaw)
        : {};
  }

  List<MapEntry<String, dynamic>> getSortedScoresDescending() {
    final allScores = getAllScores();

    final sortedEntries = allScores.entries.toList()
      ..sort((a, b) {
        final dateA = DateTime.tryParse(
            (a.value as List).last['date']?.toString() ?? '') ??
            DateTime.fromMillisecondsSinceEpoch(0);
        final dateB = DateTime.tryParse(
            (b.value as List).last['date']?.toString() ?? '') ??
            DateTime.fromMillisecondsSinceEpoch(0);
        return dateB.compareTo(dateA);
      });

    return sortedEntries;
  }

  Future<void> addScore({
    required String quizId,
    required int score,
    required int attempted,
    required int total,
  }) async {
    // 1. Get the current map of all scores
    final allScores = getAllScores();

    // 2. Prepare the data for the new score entry
    final newScoreData = {
      'score': score,
      'attempted': attempted,
      'total': total,
      'date': DateTime.now().toIso8601String(), // Record the time of completion
    };


    // 3. Get the existing list of scores for this quizId, or create a new one
    final quizScores = (allScores[quizId] as List<dynamic>?)?.toList() ?? [];

    // 4. Add the new score data to the list
    quizScores.add(newScoreData);

    // 5. Update the main scores map with the modified list
    allScores[quizId] = quizScores;

    // 6. Save the entire updated map back to Hive
    await _box.put('all_scores', allScores);
  }
}