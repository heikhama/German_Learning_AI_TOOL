import 'package:flutter/material.dart';

import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  String germanWord = "";
  String englishMeaning = "";
  int level = 1;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadWord();
  }

  Future<void> loadWord() async {

    setState(() {
      isLoading = true;
    });

    try {

      final result =
          await ApiService.getRandomWord();

      setState(() {

        germanWord =
            result["german"];

        englishMeaning =
            result["english"];

        level =
            result["level"];

        isLoading = false;
      });

    } catch (e) {

      print(e);

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "German Trainer",
        ),
      ),

      body: Center(

        child: Padding(

          padding:
              const EdgeInsets.all(20),

          child: Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              const Text(
                "German Word",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Text(
                germanWord,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Text(
                englishMeaning,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Text(
                "Level $level",
              ),

              const SizedBox(
                height: 40,
              ),

              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: loadWord,
                      child: const Text(
                        "Next Word",
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}