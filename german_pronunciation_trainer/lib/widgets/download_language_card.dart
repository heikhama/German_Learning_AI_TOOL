import 'package:flutter/material.dart';

import '../models/language_model.dart';

class DownloadLanguageCard extends StatelessWidget {

  final LanguageModel language;

  final VoidCallback? onDownload;

  final VoidCallback? onDelete;

  const DownloadLanguageCard({
    super.key,
    required this.language,
    this.onDownload,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 3,

      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            //--------------------------------------------------
            // Header
            //--------------------------------------------------

            Row(

              children: [

                Text(

                  language.flag,

                  style: const TextStyle(
                    fontSize: 34,
                  ),

                ),

                const SizedBox(width: 16),

                Expanded(

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(

                        language.name,

                        style: const TextStyle(

                          fontSize: 18,

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),

                      const SizedBox(height: 4),

                      Text(

                        language.nativeName,

                        style: TextStyle(

                          color:
                              Colors.grey.shade700,

                        ),

                      ),

                    ],

                  ),

                ),

              ],

            ),

            const SizedBox(height: 16),

            //--------------------------------------------------
            // Information
            //--------------------------------------------------

            Text(
              "Language Code : ${language.languageCode}",
            ),

            const SizedBox(height: 6),

            Text(
              "Download Size : ${language.downloadSize}",
            ),

            const SizedBox(height: 12),

            Row(

              children: [

                Icon(

                  language.downloaded

                      ? Icons.check_circle

                      : Icons.cloud_download,

                  color: language.downloaded

                      ? Colors.green

                      : Colors.orange,

                ),

                const SizedBox(width: 8),

                Text(

                  language.downloaded

                      ? "Downloaded"

                      : "Not Downloaded",

                ),

              ],

            ),

            const SizedBox(height: 20),

            //--------------------------------------------------
            // Button
            //--------------------------------------------------

            SizedBox(

              width: double.infinity,

              height: 45,

              child: language.downloaded

                  ? OutlinedButton.icon(

                      onPressed: onDelete,

                      icon: const Icon(
                        Icons.delete,
                      ),

                      label: const Text(
                        "Remove",
                      ),

                    )

                  : ElevatedButton.icon(

                      onPressed: onDownload,

                      icon: const Icon(
                        Icons.download,
                      ),

                      label: const Text(
                        "Download Language",
                      ),

                    ),

            ),

          ],

        ),

      ),

    );

  }

}