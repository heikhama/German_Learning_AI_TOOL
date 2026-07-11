class LanguageModel {

  final int id;

  final String name;

  final String nativeName;

  final String languageCode;

  final String flag;

  final String downloadSize;

  final bool downloaded;

  const LanguageModel({

    required this.id,

    required this.name,

    required this.nativeName,

    required this.languageCode,

    required this.flag,

    required this.downloadSize,

    required this.downloaded,

  });

  factory LanguageModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return LanguageModel(

      id: json["id"],

      name: json["name"] ?? "",

      nativeName: json["native_name"] ?? "",

      languageCode:
          json["language_code"] ?? "",

      flag: json["flag"] ?? "",

      downloadSize:
          json["download_size"] ?? "",

      downloaded:
          json["downloaded"] ?? false,

    );

  }

}