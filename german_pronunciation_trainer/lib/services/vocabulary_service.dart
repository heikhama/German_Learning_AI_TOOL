import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/vocabulary.dart';

import 'auth_service.dart';
import 'api_service.dart';

class VocabularyService {

  //-------------------------------------------------------
  // Vocabulary List
  //-------------------------------------------------------

  static Future<List<Vocabulary>>
      getVocabulary() async {

    final token =
        await AuthService.getToken();

    final response = await http.get(

      Uri.parse(
        "${ApiService.baseUrl}/vocabulary",
      ),

      headers: {

        "Authorization":
            "Bearer $token",

      },

    );

    if (response.statusCode != 200) {

      throw Exception(
        response.body,
      );

    }

    final List data =
        jsonDecode(response.body);

    return data

        .map(

          (e) => Vocabulary.fromJson(e),

        )

        .toList();

  }

}