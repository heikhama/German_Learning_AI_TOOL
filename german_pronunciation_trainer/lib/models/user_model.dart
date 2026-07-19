class UserModel {
  final int id;

  final String name;

  final String email;

  final String avatar;

  //--------------------------------------------------
  // Learning Preferences
  //--------------------------------------------------

  final String learningLanguage;

  final int learningLanguageId;

  final String learningCategory;

  final String learningLevel;

  final int wordsPerSession;

  //--------------------------------------------------

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.learningLanguage,
    required this.learningLanguageId,
    required this.learningCategory,
    required this.learningLevel,
    required this.wordsPerSession,
  });

  //--------------------------------------------------
  // Empty User
  //--------------------------------------------------

  factory UserModel.empty() {
    return const UserModel(
      id: 0,
      name: "",
      email: "",
      avatar: "",
      learningLanguage: "German",
      learningLanguageId: 1,
      learningCategory: "Daily Conversation",
      learningLevel: "A1",
      wordsPerSession: 20,
    );
  }

  //--------------------------------------------------
  // Login Status
  //--------------------------------------------------

  bool get isLoggedIn => id > 0;

  //--------------------------------------------------
  // JSON
  //--------------------------------------------------

  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserModel(
      id: json["id"] ?? 0,

      name: json["name"] ?? "",

      email: json["email"] ?? "",

      avatar: json["avatar"] ?? "",

      learningLanguage:
          json["learning_language"] ??
              "German",
      learningLanguageId: json["learning_language_id"] ??
              1,


      learningCategory:
          json["learning_category"] ??
              "Daily Conversation",

      learningLevel:
          json["learning_level"] ??
              "A1",

      wordsPerSession:
          json["words_per_session"] ?? 20,
    );
  }

  //--------------------------------------------------

  Map<String, dynamic> toJson() {
    return {
      "id": id,

      "name": name,

      "email": email,

      "avatar": avatar,

      "learning_language":
          learningLanguage,

      "learning_language_id":
          learningLanguageId,

      "learning_category":
          learningCategory,

      "learning_level":
          learningLevel,

      "words_per_session":
          wordsPerSession,
    };
  }

  //--------------------------------------------------

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? avatar,
    String? learningLanguage,
    int? learningLanguageId,
    String? learningCategory,
    String? learningLevel,
    int? wordsPerSession,
  }) {
    return UserModel(
      id: id ?? this.id,

      name: name ?? this.name,

      email: email ?? this.email,

      avatar: avatar ?? this.avatar,

      learningLanguage:
          learningLanguage ??
              this.learningLanguage,
      learningLanguageId:
          learningLanguageId ?? 
              this.learningLanguageId,

      learningCategory:
          learningCategory ??
              this.learningCategory,

      learningLevel:
          learningLevel ??
              this.learningLevel,

      wordsPerSession:
          wordsPerSession ??
              this.wordsPerSession,
    );
  }

  @override
  String toString() {
    return toJson().toString();
  }
}