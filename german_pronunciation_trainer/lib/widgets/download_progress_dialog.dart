import 'package:flutter/material.dart';

import '../models/download_progress.dart';

class DownloadProgressDialog extends StatelessWidget {

  final ValueNotifier<DownloadProgress?> notifier;

  const DownloadProgressDialog({

    super.key,

    required this.notifier,

  });

  @override
  Widget build(BuildContext context) {

    return AlertDialog(

      title: const Text(
        "Downloading Language",
      ),

      content: ValueListenableBuilder<DownloadProgress?>(

        valueListenable: notifier,

        builder: (

          context,

          progress,

          child,

        ) {

          final p = progress ??

              DownloadProgress(

                jobId: 0,

                status: "Preparing",

                progress: 0,

                currentStep: "Preparing",

                savedWords: 0,

                totalWords: 0,

              );

          return SizedBox(

            width: 320,

            child: Column(

              mainAxisSize: MainAxisSize.min,

              children: [

                LinearProgressIndicator(

                  value: p.progress / 100,

                ),

                const SizedBox(height: 20),

                Text(

                  "${p.progress}%",

                  style: const TextStyle(

                    fontSize: 24,

                    fontWeight: FontWeight.bold,

                  ),

                ),

                const SizedBox(height: 15),

                Text(

                  p.currentStep,

                  textAlign: TextAlign.center,

                ),

                const SizedBox(height: 15),

                Text(

                  "${p.savedWords}/${p.totalWords}",

                ),

              ],

            ),

          );

        },

      ),

    );

  }

}