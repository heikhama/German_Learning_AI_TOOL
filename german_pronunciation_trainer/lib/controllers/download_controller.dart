import 'dart:async';

import '../models/download_progress.dart';
import '../services/download_service.dart';

class DownloadController {

  Timer? _timer;

  //-------------------------------------------------------
  // Start Download
  //-------------------------------------------------------

  Future<void> start({

    required int languageId,

    required int wordCount,

    required Function(DownloadProgress) onProgress,

    required Function() onCompleted,

    required Function(String) onError,

  }) async {

    final jobId = await DownloadService.startDownload(
      languageId,
      wordCount,
    );

    if (jobId == null) {

      onError("Unable to start download.");

      return;

    }

    _timer = Timer.periodic(

      const Duration(seconds: 1),

      (timer) async {

        final progress =
            await DownloadService.getProgress(
          jobId,
        );

        if (progress == null) {
          return;
        }

        onProgress(progress);

        if (progress.status == "Completed") {

          timer.cancel();

          onCompleted();

        }

        if (progress.status == "Failed") {

          timer.cancel();

          onError(progress.currentStep);

        }

      },

    );

  }

  //-------------------------------------------------------

  void dispose() {

    _timer?.cancel();

  }

}