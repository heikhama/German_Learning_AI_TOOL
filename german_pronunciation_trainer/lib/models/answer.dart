class Answer {

  final int wordId;

  final String selectedAnswer;

  const Answer({

    required this.wordId,

    required this.selectedAnswer,

  });

  Map<String, dynamic> toJson() {

    return {

      "word_id": wordId,

      "selected_answer": selectedAnswer,

    };

  }

}