class DifficultyModel {

  final int id;

  final String level;

  const DifficultyModel({

    required this.id,

    required this.level,

  });

  factory DifficultyModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return DifficultyModel(

      id: json["id"],

      level: json["level"] ?? "",

    );

  }

}