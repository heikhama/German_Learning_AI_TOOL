import '../models/download_progress.dart';
import 'api_service.dart';

class DownloadService {

  static Future<int?> startDownload(

    int languageId,

  ) async {

    final result =

        await ApiService.downloadLanguage(

      languageId: languageId,

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

}