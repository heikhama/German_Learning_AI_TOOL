import 'package:flutter/material.dart';

import '../models/word.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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

      print("German : ${word.word}");
      print("Meaning: ${word.meaning}");
      print("Level  : ${word.level}");

      setState(() {

        currentWord = word;

        isLoading = false;
      });

    } catch (e) {

      debugPrint("Load Word Error : $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  //----------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "German AI Trainer",
        ),

        centerTitle: true,
      ),

      body: Center(

        child: Padding(

          padding: const EdgeInsets.all(20),

          child: isLoading

              ? const CircularProgressIndicator()

              : currentWord == null

                  ? const Text(
                      "No Word Found",
                    )

                  : Column(

                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [

                        const Text(

                          "German Word",

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(

                          currentWord!.word,

                          style: const TextStyle(

                            fontSize: 40,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 25),

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
                          ),
                        ),

                        const SizedBox(height: 50),

                        SizedBox(

                          width: 220,

                          child: ElevatedButton.icon(

                            icon: const Icon(
                              Icons.refresh,
                            ),

                            label: const Text(
                              "Next Word",
                            ),

                            onPressed: loadWord,
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}