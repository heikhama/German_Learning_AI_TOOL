import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../models/word.dart';

class ApiService {
  //---------------------------------------------------------
  // Change this according to your backend
  //---------------------------------------------------------

  // Android Emulator
  // static const String baseUrl = "http://10.0.2.2:8000";

  // iOS Simulator
  // static const String baseUrl = "http://localhost:8000";

  // macOS / Windows / Linux
  static const String baseUrl = "http://localhost:8000";

  //---------------------------------------------------------
  // Login
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    return jsonDecode(response.body);
  }

  //---------------------------------------------------------
  // Register
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );

    return jsonDecode(response.body);
  }

  //---------------------------------------------------------
  // Get Profile
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> getProfile(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/user/profile"),

      headers: {"Authorization": "Bearer $token"},
    );

    print("==============================");

    print("GET PROFILE");

    print("Status Code : ${response.statusCode}");

    print("Body:");

    print(response.body);

    print("==============================");

    return jsonDecode(response.body);
  }

  //---------------------------------------------------------
  // Update Profile
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> updateProfile({
    required String token,
    required String name,
  }) async {
    final response = await http.put(
      Uri.parse("$baseUrl/user/profile"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"name": name}),
    );

    return jsonDecode(response.body);
  }

  //---------------------------------------------------------
  // Upload Avatar
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> uploadAvatar({
    required String token,
    required File image,
  }) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/user/avatar"),
    );

    request.headers["Authorization"] = "Bearer $token";

    final extension = image.path.split(".").last.toLowerCase();

    request.files.add(
      await http.MultipartFile.fromPath(
        "avatar",
        image.path,
        contentType: MediaType(
          "image",
          extension == "jpg" ? "jpeg" : extension,
        ),
      ),
    );

    final streamed = await request.send();

    final response = await http.Response.fromStream(streamed);

    return jsonDecode(response.body);
  }

  //---------------------------------------------------------
  // Change Password
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> changePassword({
    required String token,
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await http.put(
      Uri.parse("$baseUrl/user/password"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "old_password": oldPassword,
        "new_password": newPassword,
      }),
    );

    return jsonDecode(response.body);
  }

  //---------------------------------------------------------
  // Change Email
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> changeEmail({
    required String token,
    required String newEmail,
  }) async {
    final response = await http.put(
      Uri.parse("$baseUrl/user/email"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"email": newEmail}),
    );

    return jsonDecode(response.body);
  }

  //---------------------------------------------------------
// Random Word
//---------------------------------------------------------

static Future<Word> getRandomWord({

  required String token,

}) async {

  final response = await http.get(

    Uri.parse("$baseUrl/words/random"),

    headers: {

      "Authorization": "Bearer $token",

    },

  );

  print("==================================");
  print("GET RANDOM WORD");
  print("Status Code : ${response.statusCode}");
  print("Response:");
  print(response.body);
  print("==================================");

  if (response.statusCode != 200) {

    throw Exception(response.body);

  }

  return Word.fromJson(

    jsonDecode(response.body),

  );

}

  //---------------------------------------------------------
  // Get Learning Preferences
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> getPreferences({
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse("$baseUrl/user/preferences"),

      headers: {"Authorization": "Bearer $token"},
    );

    print("======================================");
    print("GET PREFERENCES");
    print(response.body);
    print("======================================");

    return jsonDecode(response.body);
  }

  //---------------------------------------------------------
  // Update Learning Preferences
  //---------------------------------------------------------

  static Future<Map<String, dynamic>> updatePreferences({
  required String token,
  required int learningLanguageId,
  required int learningCategoryId,
  required int difficultyLevelId,
  required int wordsPerSession,
}) async {

  final response = await http.put(
    Uri.parse("$baseUrl/user/preferences"),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "learning_language_id": learningLanguageId,
      "learning_category_id": learningCategoryId,
      "difficulty_level_id": difficultyLevelId,
      "words_per_session": wordsPerSession,
    }),
  );

  return jsonDecode(response.body);
}


  static Future<Map<String, dynamic>> getLanguages() async {

  final response = await http.get(
    Uri.parse("$baseUrl/master/languages"),
  );

  return jsonDecode(response.body);
}

static Future<Map<String, dynamic>> getCategories() async {

  final response = await http.get(
    Uri.parse("$baseUrl/master/categories"),
  );

  return jsonDecode(response.body);
}

static Future<Map<String, dynamic>> getDifficultyLevels() async {

  final response = await http.get(
    Uri.parse("$baseUrl/master/difficulty-levels"),
  );

  return jsonDecode(response.body);
}


//---------------------------------------------------------
// Download Language
//---------------------------------------------------------

static Future<Map<String,dynamic>> downloadLanguage({

  required int languageId,
  required int wordCount,

}) async {

  final response = await http.post(

    Uri.parse(

      "$baseUrl/language/download/$languageId?word_count=$wordCount",

    ),

  );

  return jsonDecode(response.body);

}

//---------------------------------------------------------
// Download Status
//---------------------------------------------------------

static Future<Map<String,dynamic>> getDownloadStatus(

  int jobId,

) async {

  final response = await http.get(

    Uri.parse(

      "$baseUrl/language/download/status/$jobId",

    ),

  );

  return jsonDecode(response.body);

}




}
