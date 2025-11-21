class Category {
  final String id;
  final String title;
  final bool isActive;
  Category({required this.id, required this.title, this.isActive = false});
}

class QuizSummary {
  final String id;
  final String categoryId;
  final String title;
  final int totalQuestions;
  final String duration; // "1 hour 15 min"
  final String rating; // "4.8"
  final String imageAsset;
  final bool bordered;

  QuizSummary({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.totalQuestions,
    required this.duration,
    required this.rating,
    this.imageAsset = '',
    this.bordered = false,
  });
}

class QuizDetail {
  final String id;
  final String title;
  final String description;
  final int pointsPerCorrect;
  final int totalQuestions;
  final String duration;
  final List<String> rules;
  final List<Question> questions;

  QuizDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.pointsPerCorrect,
    required this.totalQuestions,
    required this.duration,
    required this.rules,
    required this.questions,
  });
}

class Question {
  final String id;
  final String text;
  final List<Option> options;
  final String correctOptionId;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctOptionId,
  });
}

class Option {
  final String id;
  final String label; // "A", "B"
  final String text;

  Option({required this.id, required this.label, required this.text});
}