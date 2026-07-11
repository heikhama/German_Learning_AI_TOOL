class Vocabulary {

  final int id;

  final String word;

  final String meaning;

  final String pronunciation;

  final String partOfSpeech;

  final String cefrLevel;

  final String category;

  final String exampleSentence;

  final String exampleTranslation;

  final String audioUrl;

  final String imageUrl;

  Vocabulary({

    required this.id,

    required this.word,

    required this.meaning,

    required this.pronunciation,

    required this.partOfSpeech,

    required this.cefrLevel,

    required this.category,

    required this.exampleSentence,

    required this.exampleTranslation,

    required this.audioUrl,

    required this.imageUrl,

  });

  factory Vocabulary.fromJson(
    Map<String, dynamic> json,
  ) {

    return Vocabulary(

      id: json["id"],

      word: json["word"] ?? "",

      meaning: json["meaning"] ?? "",

      pronunciation: json["pronunciation"] ?? "",

      partOfSpeech: json["part_of_speech"] ?? "",

      cefrLevel: json["cefr_level"] ?? "",

      category: json["category"] ?? "",

      exampleSentence:
          json["example_sentence"] ?? "",

      exampleTranslation:
          json["example_translation"] ?? "",

      audioUrl: json["audio_url"] ?? "",

      imageUrl: json["image_url"] ?? "",

    );

  }

}