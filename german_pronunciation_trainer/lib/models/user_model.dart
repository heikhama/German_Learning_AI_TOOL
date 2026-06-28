class UserModel {
  final int id;
  final String name;
  final String email;
  final String avatar;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
  });

  ///---------------------------------------------
  /// Create object from JSON
  ///---------------------------------------------
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      avatar: json["avatar"] ?? "",
    );
  }

  ///---------------------------------------------
  /// Convert object to JSON
  ///---------------------------------------------
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "avatar": avatar,
    };
  }

  ///---------------------------------------------
  /// Copy object with new values
  ///---------------------------------------------
  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }

  ///---------------------------------------------
  /// Empty user
  ///---------------------------------------------
  factory UserModel.empty() {
    return const UserModel(
      id: 0,
      name: "",
      email: "",
      avatar: "",
    );
  }

  ///---------------------------------------------
  /// Login status
  ///---------------------------------------------
  bool get isLoggedIn => id > 0;

  @override
  String toString() {
    return '''
UserModel(
  id: $id,
  name: $name,
  email: $email,
  avatar: $avatar
)
''';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is UserModel &&
            other.id == id &&
            other.name == name &&
            other.email == email &&
            other.avatar == avatar;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      avatar.hashCode;
}