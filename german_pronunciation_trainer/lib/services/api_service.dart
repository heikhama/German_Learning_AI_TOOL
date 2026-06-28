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

  static Future<Word> getRandomWord() async {
    final response = await http.get(Uri.parse("$baseUrl/words/random"));

    if (response.statusCode != 200) {
      throw Exception("Failed to load word");
    }

    final Map<String, dynamic> json = jsonDecode(response.body);

    // If backend returns:
    // {
    //   "success": true,
    //   "data": {...}
    // }

    if (json.containsKey("data")) {
      return Word.fromJson(json["data"]);
    }

    // If backend returns the word object directly
    return Word.fromJson(json);
  }
}
