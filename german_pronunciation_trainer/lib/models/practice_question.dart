class PracticeQuestion {
  final int wordId;
  final String word;
  final List<String> options;
  final String correctAnswer;

  PracticeQuestion({
    required this.wordId,
    required this.word,
    required this.options,
    required this.correctAnswer,
  });

  factory PracticeQuestion.fromJson(Map<String, dynamic> json) {
    return PracticeQuestion(
      wordId: json["word_id"],
      word: json["word"],
      options: List<String>.from(json["options"]),
      correctAnswer: json["correct_answer"],
    );
  }
}

