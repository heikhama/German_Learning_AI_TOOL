class Word {

  final String german;
  final String english;
  final int level;

  Word({
    required this.german,
    required this.english,
    required this.level,
  });

  factory Word.fromJson(
      Map<String, dynamic> json) {

    return Word(
      german: json["german"],
      english: json["english"],
      level: json["level"],
    );
  }
}