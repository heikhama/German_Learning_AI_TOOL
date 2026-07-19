class DashboardModel {
  final int wordsLearned;

  final int accuracy;

  final int streak;

  final int bestScore;

  final int lastScore;

  final int testsTaken;

  final double averageScore;

  const DashboardModel({
    required this.wordsLearned,
    required this.accuracy,
    required this.streak,
    required this.bestScore,
    required this.lastScore,
    required this.testsTaken,
    required this.averageScore,
  });

  factory DashboardModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DashboardModel(
      wordsLearned: json["words_learned"] ?? 0,

      accuracy: json["accuracy"] ?? 0,

      streak: json["streak"] ?? 0,

      bestScore: json["best_score"] ?? 0,

      lastScore: json["last_score"] ?? 0,

      testsTaken: json["tests_taken"] ?? 0,

      averageScore:
          (json["average_score"] ?? 0).toDouble(),
    );
  }
}