import 'dart:convert';

import 'package:http/http.dart'
    as http;

import '../models/word.dart';

class ApiService {

  static const String baseUrl =
      "http://localhost:8000";

  //------------------------------------------------
  // Login
  //------------------------------------------------

  static Future<Map<String, dynamic>>
      login(
    String email,
    String password,
  ) async {

    final response = await http.post(

      Uri.parse("$baseUrl/auth/login"),

      headers: {

        "Content-Type":
            "application/json",
      },

      body: jsonEncode({

        "email": email,

        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }

  //------------------------------------------------
  // Random Word
  //------------------------------------------------

  static Future<Word>
      getRandomWord() async {

    final response = await http.get(

      Uri.parse(
        "$baseUrl/words/random",
      ),
    );

    final json =
        jsonDecode(response.body);

    return Word.fromJson(json);
  }
}