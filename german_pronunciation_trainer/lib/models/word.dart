class Word {

  final int id;

  final String word;

  final String meaning;

  final String pronunciation;

  final String example;

  final String level;

  final String category;

  const Word({

    required this.id,

    required this.word,

    required this.meaning,

    required this.pronunciation,

    required this.example,

    required this.level,

    required this.category,
  });

  factory Word.fromJson(
      Map<String, dynamic> json) {

    return Word(

      id: int.tryParse(
              json["id"].toString()) ??
          0,

      // Backend field = german
      word:
          json["german"]?.toString() ??
              "",

      // Backend field = english
      meaning:
          json["english"]?.toString() ??
              "",

      pronunciation:
          json["pronunciation"]
                  ?.toString() ??
              "",

      example:
          json["example"]?.toString() ??
              "",

      level:
          json["level"]?.toString() ??
              "1",

      category:
          json["category"]?.toString() ??
              "",
    );
  }

  Map<String, dynamic> toJson() {

    return {

      "id": id,

      "german": word,

      "english": meaning,

      "pronunciation":
          pronunciation,

      "example": example,

      "level": level,

      "category": category,
    };
  }
}