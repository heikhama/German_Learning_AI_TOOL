import '../models/download_progress.dart';
import 'api_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/dashboard_model.dart';

import 'auth_service.dart';

class DownloadService {

  static Future<int?> startDownload(

    int languageId,
    int wordCount,

  ) async {

    final result =

        await ApiService.downloadLanguage(

      languageId: languageId,
      wordCount: wordCount,

    );

    if(result["success"]==true){

      return result["job_id"];

    }

    return null;

  }

  //--------------------------------------------------

  static Future<DownloadProgress?>

      getProgress(

    int jobId,

  ) async {

    final result =

        await ApiService.getDownloadStatus(

      jobId,

    );

    if(result["success"]!=true){

      return null;

    }

    return DownloadProgress.fromJson(

      result["data"],

    );

  }

  static Future<DashboardModel> getDashboard({
    required int userId,
    required int languageId,
  }) async {
    final token = await AuthService.getToken();

    final response = await http.get(
      Uri.parse(
        "${ApiService.baseUrl}/practice/dashboard"
        "?user_id=$userId&language_id=$languageId",
      ),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load dashboard");
    }

    return DashboardModel.fromJson(
      jsonDecode(response.body),
    );
  }


}