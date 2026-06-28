// class UserModel {
//   final int id;
//   final String name;
//   final String email;
//   final String avatar;

//   const UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.avatar,
//   });

//   ///---------------------------------------------
//   /// Create object from JSON
//   ///---------------------------------------------
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json["id"] ?? 0,
//       name: json["name"] ?? "",
//       email: json["email"] ?? "",
//       avatar: json["avatar"] ?? "",
//     );
//   }

//   ///---------------------------------------------
//   /// Convert object to JSON
//   ///---------------------------------------------
//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "name": name,
//       "email": email,
//       "avatar": avatar,
//     };
//   }

//   ///---------------------------------------------
//   /// Copy object with new values
//   ///---------------------------------------------
//   UserModel copyWith({
//     int? id,
//     String? name,
//     String? email,
//     String? avatar,
//   }) {
//     return UserModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       email: email ?? this.email,
//       avatar: avatar ?? this.avatar,
//     );
//   }

//   ///---------------------------------------------
//   /// Empty user
//   ///---------------------------------------------
//   factory UserModel.empty() {
//     return const UserModel(
//       id: 0,
//       name: "",
//       email: "",
//       avatar: "",
//     );
//   }

//   ///---------------------------------------------
//   /// Login status
//   ///---------------------------------------------
//   bool get isLoggedIn => id > 0;

//   @override
//   String toString() {
//     return '''
// UserModel(
//   id: $id,
//   name: $name,
//   email: $email,
//   avatar: $avatar
// )
// ''';
//   }

//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         other is UserModel &&
//             other.id == id &&
//             other.name == name &&
//             other.email == email &&
//             other.avatar == avatar;
//   }

//   @override
//   int get hashCode =>
//       id.hashCode ^
//       name.hashCode ^
//       email.hashCode ^
//       avatar.hashCode;
// }

class UserModel {
  final int id;

  final String name;

  final String email;

  final String avatar;

  //--------------------------------------------------
  // Learning Preferences
  //--------------------------------------------------

  final String learningLanguage;

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