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

        borderRadius:
            BorderRadius.circular(20),

      ),

      child: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Text(

              word.word,

              style: const TextStyle(

                fontSize: 34,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 15),

            Text(

              word.meaning,

              style: const TextStyle(

                fontSize: 22,

              ),

            ),

            const SizedBox(height: 15),

            Text(

              "Level ${word.level}",

            ),

            const SizedBox(height: 25),

            Row(

              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,

              children: [

                IconButton(

                  onPressed: () {},

                  icon: const Icon(
                      Icons.volume_up),

                ),

                IconButton(

                  onPressed: () {},

                  icon: const Icon(
                      Icons.mic),

                ),

                IconButton(

                  onPressed: () {},

                  icon: const Icon(
                      Icons.favorite_border),

                ),

              ],

            ),

            const SizedBox(height: 15),

            ElevatedButton(

              onPressed: onNext,

              child:
                  const Text("Next Word"),

            )

          ],

        ),

      ),

    );

  }

}