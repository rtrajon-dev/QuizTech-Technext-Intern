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
}
