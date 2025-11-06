import 'dart:developer';

/// Utility functions for handling quiz score calculations and data normalization.
class ScoreUtils {
  /// Converts the raw Hive-stored scores data into a proper Map<String, dynamic>.
  static Map<String, dynamic> normalizeAllScores(dynamic allScoresRaw) {
    try {
      if (allScoresRaw is Map) {
        return Map<String, dynamic>.from(allScoresRaw);
      }
    } catch (e, s) {
      log('Error normalizing scores: $e', stackTrace: s);
    }
    return {};
  }

  /// Calculates the total score using only the latest attempt of each quiz.
  /// [multiplier] allows you to customize how each score contributes to total.
  static int calculateTotalScore(Map<String, dynamic> allScores, {int multiplier = 10}) {
    int totalScore = 0;

    try {
      allScores.forEach((quizId, scoresListRaw) {
        final scoresList = (scoresListRaw is List) ? scoresListRaw : [];
        if (scoresList.isNotEmpty) {
          final latestData = (scoresList.last is Map)
              ? Map<String, dynamic>.from(scoresList.last)
              : {};
          final score = (latestData['score'] is num)
              ? (latestData['score'] as num).toInt()
              : 0;

          totalScore += score * multiplier;
        }
      });
    } catch (e, s) {
      log('Error calculating total score: $e', stackTrace: s);
    }

    return totalScore;
  }

  /// Extracts the latest score data for each quiz as a list.
  static List<Map<String, dynamic>> extractLatestScores(Map<String, dynamic> allScores) {
    final List<Map<String, dynamic>> latestScores = [];

    try {
      allScores.forEach((quizId, scoresListRaw) {
        final scoresList = (scoresListRaw is List) ? scoresListRaw : [];
        if (scoresList.isNotEmpty) {
          final latestData = (scoresList.last is Map)
              ? Map<String, dynamic>.from(scoresList.last)
              : {};
          latestScores.add({
            'quizId': quizId,
            'score': latestData['score'] ?? 0,
            'total': latestData['total'] ?? 0,
            'date': latestData['date'] ?? '',
          });
        }
      });
    } catch (e, s) {
      log('Error extracting latest scores: $e', stackTrace: s);
    }

    return latestScores;
  }
}
