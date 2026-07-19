import 'dart:convert';
import 'package:german_pronunciation_trainer/services/api_service.dart';
import 'package:german_pronunciation_trainer/services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../models/practice_question.dart';


class PracticeService {

  static const baseUrl = "http://127.0.0.1:8000";

  // static Future<void> submitResult({
  //   required int languageId,
  //   required int score,
  //   required int totalQuestions,
  //   required int timeTaken,
  // }) async {

  //   final response = await http.post(
  //     Uri.parse("$baseUrl/practice/submit"),
  //     headers: {
  //       "Content-Type": "application/json",
  //     },
  //     body: jsonEncode({
  //       "language_id": languageId,
  //       "score": score,
  //       "total_questions": totalQuestions,
  //       "time_taken": timeTaken,
  //     }),
  //   );

  //   if (response.statusCode != 200) {
  //     throw Exception("Failed to submit result");
  //   }
  // }

  static Future<void> submitPractice({
  required int userId,
  required int languageId,
  required int score,
  required int totalQuestions,
  required int timeTaken,
}) async {
  final token = await AuthService.getToken();

  final response = await http.post(
    Uri.parse("${ApiService.baseUrl}/practice/submit"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
    body: jsonEncode({
      "user_id": userId,
      "language_id": languageId,
      "score": score,
      "total_questions": totalQuestions,
      "time_taken": timeTaken,
    }),
  );

  print(response.statusCode);
  print(response.body);

  if (response.statusCode != 200) {
    throw Exception("Failed to submit practice");
  }
}


  static Future<List<PracticeQuestion>> getQuestions(
      int languageId) async {

    final response = await http.get(
      Uri.parse(
        "$baseUrl/practice/questions?language_id=$languageId",
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load questions");
    }

    final data = jsonDecode(response.body);

    final List list = data["questions"];

    return list
        .map((e) => PracticeQuestion.fromJson(e))
        .toList();
  }


}