import 'package:flutter/material.dart';

import '../models/word.dart';
import '../services/api_service.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() =>
      _VocabularyScreenState();
}

class _VocabularyScreenState
    extends State<VocabularyScreen> {

  Word? currentWord;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadWord();
  }

  //----------------------------------------------------------
  // Load Random Word
  //----------------------------------------------------------

  Future<void> loadWord() async {

    setState(() {

      isLoading = true;

    });

    try {

      final Word word =
          await ApiService.getRandomWord();

      // debugPrint("German : ${word.word}");
      // debugPrint("Meaning: ${word.meaning}");
      // debugPrint("Level  : ${word.level}");

      if (!mounted) return;

      setState(() {

        currentWord = word;

        isLoading = false;

      });

    } catch (e) {

      debugPrint("Load Word Error : $e");

      if (!mounted) return;

      setState(() {

        isLoading = false;

      });

    }

  }

  //----------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.all(20),

      child: Center(

        child: isLoading

            ? const CircularProgressIndicator()

            : currentWord == null

                ? const Text(

                    "No Word Found",

                    style: TextStyle(
                      fontSize: 18,
                    ),

                  )

                : Column(

                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      const Text(

                        "German Word",

                        style: TextStyle(

                          fontSize: 18,

                          fontWeight:
                              FontWeight.w500,

                        ),

                      ),

                      const SizedBox(height: 20),

                      Text(

                        currentWord!.word,

                        style: const TextStyle(

                          fontSize: 42,

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),

                      const SizedBox(height: 20),

                      Text(

                        currentWord!.meaning,

                        style: const TextStyle(

                          fontSize: 24,

                        ),

                      ),

                      const SizedBox(height: 15),

                      Text(

                        "Level : ${currentWord!.level}",

                        style: const TextStyle(

                          fontSize: 18,

                          color: Colors.grey,

                        ),

                      ),

                      const SizedBox(height: 40),

                      SizedBox(

                        width: 220,

                        child: ElevatedButton.icon(

                          onPressed: loadWord,

                          icon: const Icon(
                            Icons.refresh,
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