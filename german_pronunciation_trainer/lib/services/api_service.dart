import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {

// static const String baseUrl =
// "http://127.0.0.1:8000";

static const String baseUrl =
    "http://localhost:8000";

static Future<Map<String, dynamic>> login(
String email,
String password) async {

final response = await http.post(
  Uri.parse("$baseUrl/auth/login"),
  headers: {
    "Content-Type": "application/json"
  },
  body: jsonEncode({
    "email": email,
    "password": password
  }),
);
print("Status Code: ${response.statusCode}");
print("Response Body: ${response.body}");
return jsonDecode(response.body);

}

static Future<Map<String, dynamic>>
getRandomWord() async {

  final response = await http.get(
    Uri.parse(
      "$baseUrl/words/random",
    ),
  );

  return jsonDecode(
      response.body);
}

}
