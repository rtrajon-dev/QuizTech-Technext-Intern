import 'package:flutter/foundation.dart';
import 'package:loginsignup/services/quiz_service.dart';

class ScoreProvider with ChangeNotifier {
  final QuizService _quizService = QuizService();

  List<MapEntry<String, dynamic>> _scores = [];
  List<MapEntry<String, dynamic>> get scores => _scores;

  void loadScores() {
    _scores = _quizService.getSortedScoresDescending();
    notifyListeners();
  }
}
