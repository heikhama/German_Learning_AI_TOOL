class PracticeResultResponse {

  final int score;

  final int totalQuestions;

  final double percentage;

  final int timeTaken;

  final int correctAnswers;

  final int wrongAnswers;

  const PracticeResultResponse({

    required this.score,

    required this.totalQuestions,

    required this.percentage,

    required this.timeTaken,

    required this.correctAnswers,

    required this.wrongAnswers,

  });

  factory PracticeResultResponse.fromJson(

      Map<String, dynamic> json) {

    return PracticeResultResponse(

      score: json["score"],

      totalQuestions: json["total_questions"],

      percentage:
          (json["percentage"] as num).toDouble(),

      timeTaken: json["time_taken"],

      correctAnswers: json["correct_answers"],

      wrongAnswers: json["wrong_answers"],

    );

  }

}