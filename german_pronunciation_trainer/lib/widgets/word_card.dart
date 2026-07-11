import 'package:flutter/material.dart';

import '../models/word.dart';

class WordCard extends StatelessWidget {

  final Word word;

  final VoidCallback onNext;

  const WordCard({

    super.key,

    required this.word,

    required this.onNext,

  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 5,

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(20),

      ),

      child: Padding(

        padding: const EdgeInsets.all(24),

        child: Column(

          mainAxisSize: MainAxisSize.min,

          children: [

            //--------------------------------------------------
            // Word
            //--------------------------------------------------

            Text(

              word.word,

              textAlign: TextAlign.center,

              style: const TextStyle(

                fontSize: 34,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 20),

            //--------------------------------------------------
            // English Meaning
            //--------------------------------------------------

            Text(

              word.meaning,

              textAlign: TextAlign.center,

              style: const TextStyle(

                fontSize: 22,

                color: Colors.grey,

              ),

            ),

            const SizedBox(height: 30),

            //--------------------------------------------------
            // Action Buttons
            //--------------------------------------------------

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [

                IconButton(

                  tooltip: "Listen",

                  onPressed: () {

                    // TODO: Text-to-Speech

                  },

                  icon: const Icon(

                    Icons.volume_up,

                    size: 30,

                  ),

                ),

                IconButton(

                  tooltip: "Practice",

                  onPressed: () {

                    // TODO: Speech Recognition

                  },

                  icon: const Icon(

                    Icons.mic,

                    size: 30,

                  ),

                ),

                IconButton(

                  tooltip: "Favorite",

                  onPressed: () {

                    // TODO: Save Favorite

                  },

                  icon: const Icon(

                    Icons.favorite_border,

                    size: 30,

                  ),

                ),

              ],

            ),

            const SizedBox(height: 25),

            //--------------------------------------------------
            // Next Word Button
            //--------------------------------------------------

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                onPressed: onNext,

                icon: const Icon(

                  Icons.arrow_forward,

                ),

                label: const Text(

                  "Next Word",

                ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}