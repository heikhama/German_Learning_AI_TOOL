class DownloadProgress {

  final int jobId;

  final String status;

  final int progress;

  final String currentStep;

  final int savedWords;

  final int totalWords;

  DownloadProgress({

    required this.jobId,

    required this.status,

    required this.progress,

    required this.currentStep,

    required this.savedWords,

    required this.totalWords,

  });

  factory DownloadProgress.fromJson(
    Map<String, dynamic> json,
  ) {

    return DownloadProgress(

      jobId: json["job_id"],

      status: json["status"],

      progress: json["progress"],

      currentStep: json["current_step"],

      savedWords: json["saved_words"],

      totalWords: json["total_words"],

    );

  }

}