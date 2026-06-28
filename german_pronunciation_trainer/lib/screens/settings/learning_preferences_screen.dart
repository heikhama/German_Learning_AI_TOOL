import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../services/popup_service.dart';

class LearningPreferencesScreen extends StatefulWidget {
  const LearningPreferencesScreen({super.key});

  @override
  State<LearningPreferencesScreen> createState() =>
      _LearningPreferencesScreenState();
}

class _LearningPreferencesScreenState
    extends State<LearningPreferencesScreen> {

  bool loading = true;
  bool saving = false;

  //------------------------------------------------------
  // Default Values
  //------------------------------------------------------

  String language = "German";

  String category = "Daily Conversation";

  String level = "A1";

  int wordsPerSession = 20;

  //------------------------------------------------------
  // Dropdown Lists
  //------------------------------------------------------

  final List<String> languages = [

    "German",

    "English",

    "French",

    "Spanish",

    "Italian",

    "Japanese",

    "Korean",

    "Chinese",

    "Russian",

  ];

  final List<String> categories = [

    "Daily Conversation",

    "Travel",

    "Technology",

    "Business",

    "Medical",

    "Education",

    "Shopping",

    "Food",

    "Sports",

    "Grammar",

    "Pronunciation",

    "Nouns",

    "Verbs",

    "Adjectives",

    "Numbers",

    "Family",

  ];

  final List<String> levels = [

    "A1",

    "A2",

    "B1",

    "B2",

    "C1",

    "C2",

  ];

  final List<int> sessionWords = [

    5,

    10,

    20,

    30,

    50,

    100,

  ];

  //------------------------------------------------------

  @override
  void initState() {
    super.initState();

    loadPreference();
  }

  //------------------------------------------------------

  Future<void> loadPreference() async {

    final result =
        await AuthService.getPreferences();

    if (!mounted) return;

    if (result["success"] == true) {

      final data = result["data"];

      language = data["learning_language"];

      category = data["learning_category"];

      level = data["learning_level"];

      wordsPerSession =
          data["words_per_session"];
    }

    setState(() {

      loading = false;

    });

  }

  //------------------------------------------------------

  Future<void> savePreference() async {

    setState(() {

      saving = true;

    });

    final result =
        await AuthService.updatePreferences(

      language: language,

      category: category,

      level: level,

      wordsPerSession: wordsPerSession,

    );

    if (!mounted) return;

    setState(() {

      saving = false;

    });

    if (result["success"] == true) {

      await PopupService.success(

        context,

        result["message"],

      );

      Navigator.pop(context, true);

    } else {

      await PopupService.error(

        context,

        result["message"],

      );

    }

  }

  //------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Learning Preferences",
        ),

      ),

      body: loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : SingleChildScrollView(

              padding:
                  const EdgeInsets.all(20),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Learning Language",

                    style: TextStyle(

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  DropdownButtonFormField(

                    value: language,

                    items: languages.map(

                      (e) => DropdownMenuItem(

                        value: e,

                        child: Text(e),

                      ),

                    ).toList(),

                    onChanged: (v) {

                      setState(() {

                        language = v!;

                      });

                    },

                  ),

                  const SizedBox(height: 25),

                  const Text(

                    "Learning Category",

                    style: TextStyle(

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  DropdownButtonFormField(

                    value: category,

                    items: categories.map(

                      (e) => DropdownMenuItem(

                        value: e,

                        child: Text(e),

                      ),

                    ).toList(),

                    onChanged: (v) {

                      setState(() {

                        category = v!;

                      });

                    },

                  ),

                  const SizedBox(height: 25),

                  const Text(

                    "Difficulty",

                    style: TextStyle(

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  DropdownButtonFormField(

                    value: level,

                    items: levels.map(

                      (e) => DropdownMenuItem(

                        value: e,

                        child: Text(e),

                      ),

                    ).toList(),

                    onChanged: (v) {

                      setState(() {

                        level = v!;

                      });

                    },

                  ),

                  const SizedBox(height: 25),

                  const Text(

                    "Words Per Session",

                    style: TextStyle(

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  DropdownButtonFormField(

                    value: wordsPerSession,

                    items: sessionWords.map(

                      (e) => DropdownMenuItem(

                        value: e,

                        child: Text("$e Words"),

                      ),

                    ).toList(),

                    onChanged: (v) {

                      setState(() {

                        wordsPerSession = v!;

                      });

                    },

                  ),

                  const SizedBox(height: 40),

                  SizedBox(

                    width: double.infinity,

                    height: 50,

                    child: ElevatedButton(

                      onPressed:
                          saving
                              ? null
                              : savePreference,

                      child: saving

                          ? const CircularProgressIndicator()

                          : const Text(

                              "SAVE PREFERENCES",

                            ),

                    ),

                  ),

                ],

              ),

            ),

    );

  }

}