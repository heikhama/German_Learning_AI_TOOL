import 'dart:convert';

import 'package:http/http.dart'
    as http;

import '../models/user_profile.dart';

import 'auth_service.dart';

import 'api_service.dart';

class ProfileService {

  static Future<UserProfile>
      getProfile() async {

    final token =
        await AuthService.getToken();

    final response = await http.get(

      Uri.parse(
          "${ApiService.baseUrl}/user/profile"),

      headers: {

        "Authorization":
            "Bearer $token",

      },

    );

    final json =
        jsonDecode(response.body);

    return UserProfile.fromJson(json);

  }

}