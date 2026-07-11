class Word {

  final int id;

  final String word;

  final String meaning;

  Word({

    required this.id,

    required this.word,

    required this.meaning,

  });

  factory Word.fromJson(

    Map<String, dynamic> json,

  ) {

    return Word(

      id: json["id"],

      word: json["word"],

      meaning: json["meaning"],

    );

  }

}