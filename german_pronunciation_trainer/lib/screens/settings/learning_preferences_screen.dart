import 'package:flutter/material.dart';

import '../../models/category_model.dart';
import '../../models/difficulty_model.dart';
import '../../models/language_model.dart';

import '../../services/auth_service.dart';
import '../../services/master_service.dart';
import '../../services/popup_service.dart';

import '../../widgets/category_dropdown.dart';
import '../../widgets/difficulty_dropdown.dart';
import '../../widgets/download_language_card.dart';
import '../../widgets/language_dropdown.dart';

import '../../models/download_progress.dart';
import '../../controllers/download_controller.dart';
import '../../widgets/download_progress_dialog.dart';

class LearningPreferencesScreen extends StatefulWidget {
  const LearningPreferencesScreen({super.key});

  @override
  State<LearningPreferencesScreen> createState() =>
      _LearningPreferencesScreenState();
}

class _LearningPreferencesScreenState extends State<LearningPreferencesScreen> {
  //------------------------------------------------------
  // Loading
  //------------------------------------------------------

  bool loading = true;

  bool saving = false;

  late final DownloadController controller;

  // DownloadController controller = DownloadController();

  // DownloadProgress? progress;
  final ValueNotifier<DownloadProgress?> progressNotifier = ValueNotifier(null);

  //------------------------------------------------------
  // Master Data
  //------------------------------------------------------

  List<LanguageModel> languages = [];

  List<CategoryModel> categories = [];

  List<DifficultyModel> levels = [];

  //------------------------------------------------------
  // Selected Values
  //------------------------------------------------------

  int? selectedLanguageId;

  int? selectedCategoryId;

  int? selectedDifficultyId;

  int wordsPerSession = 20;

  final List<int> sessionList = [5, 10, 20, 30, 50, 100,10000];

  //------------------------------------------------------

  @override
  void initState() {
    super.initState();

    controller = DownloadController();

    loadData();
  }

  @override
  void dispose() {
    controller.dispose();

    progressNotifier.dispose();

    super.dispose();
  }

  //------------------------------------------------------
  // Load Data
  //------------------------------------------------------

  Future<void> loadData() async {
    if (!mounted) return;

    setState(() {
      loading = true;
    });

    try {
      //--------------------------------------------------
      // Languages
      //--------------------------------------------------

      print("=================================");
      print("Loading Languages");
      print("=================================");

      final languageList = await MasterService.getLanguages();

      print(languageList);

      languages = languageList;

      //--------------------------------------------------
      // Categories
      //--------------------------------------------------

      print("=================================");
      print("Loading Categories");
      print("=================================");

      final categoryList = await MasterService.getCategories();

      print(categoryList);

      categories = categoryList;

      //--------------------------------------------------
      // Difficulty Levels
      //--------------------------------------------------

      print("=================================");
      print("Loading Levels");
      print("=================================");

      final levelList = await MasterService.getLevels();

      print(levelList);

      levels = levelList;

      //--------------------------------------------------
      // User Preferences
      //--------------------------------------------------

      print("=================================");
      print("Loading Preferences");
      print("=================================");

      final pref = await AuthService.getPreferences();

      print(pref);

      if (pref["success"] == true) {
        final data = pref["data"] as Map<String, dynamic>;

        selectedLanguageId = data["learning_language_id"];

        selectedCategoryId = data["learning_category_id"];

        selectedDifficultyId = data["difficulty_level_id"];

        wordsPerSession = data["words_per_session"] ?? 20;
      }
    } catch (e, stackTrace) {
      debugPrint("=================================");
      debugPrint("Learning Preference Error");
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      debugPrint("=================================");

      if (mounted) {
        await PopupService.error(context, e.toString());
      }
    }

    if (!mounted) return;

    setState(() {
      loading = false;
    });
  }

  //------------------------------------------------------
  // Helpers
  //------------------------------------------------------

  LanguageModel? get selectedLanguage {
    try {
      return languages.firstWhere((e) => e.id == selectedLanguageId);
    } catch (_) {
      return null;
    }
  }

  CategoryModel? get selectedCategory {
    try {
      return categories.firstWhere((e) => e.id == selectedCategoryId);
    } catch (_) {
      return null;
    }
  }

  DifficultyModel? get selectedDifficulty {
    try {
      return levels.firstWhere((e) => e.id == selectedDifficultyId);
    } catch (_) {
      return null;
    }
  }

  //------------------------------------------------------
  // Save Preferences
  //------------------------------------------------------

  Future<void> savePreference() async {
    //----------------------------------------------------
    // Validation
    //----------------------------------------------------

    if (selectedLanguageId == null) {
      await PopupService.error(context, "Please select a language.");

      return;
    }

    if (selectedCategoryId == null) {
      await PopupService.error(context, "Please select a category.");

      return;
    }

    if (selectedDifficultyId == null) {
      await PopupService.error(context, "Please select a difficulty level.");

      return;
    }

    //----------------------------------------------------

    setState(() {
      saving = true;
    });

    try {
      final result = await AuthService.updatePreferences(
        learningLanguageId: selectedLanguageId!,

        learningCategoryId: selectedCategoryId!,

        difficultyLevelId: selectedDifficultyId!,

        wordsPerSession: wordsPerSession,
      );

      if (!mounted) return;

      if (result["success"] == true) {
        await PopupService.success(
          context,

          result["message"] ?? "Preferences saved successfully.",
        );

        Navigator.pop(context, true);
      } else {
        await PopupService.error(
          context,

          result["message"] ?? "Unable to save preferences.",
        );
      }
    } catch (e) {
      if (!mounted) return;

      await PopupService.error(context, e.toString());
    }

    if (!mounted) return;

    setState(() {
      saving = false;
    });
  }

  //------------------------------------------------------
  // Download Language
  //------------------------------------------------------

  Future<void> downloadLanguage(LanguageModel language) async {
    showDialog(
      context: context,

      barrierDismissible: false,

      builder: (_) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return DownloadProgressDialog(notifier: progressNotifier);
          },
        );
      },
    );

    await controller.start(
      languageId: selectedLanguageId!,
      wordCount: wordsPerSession,

      //--------------------------------------------------
      // Progress Update
      //--------------------------------------------------
      onProgress: (progress) {
        progressNotifier.value = progress;
      },

      //--------------------------------------------------
      // Download Completed
      //--------------------------------------------------
      onCompleted: () async {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }

        await loadData();

        if (!mounted) return;

        await PopupService.success(
          context,

          "Language downloaded successfully.",
        );
      },

      //--------------------------------------------------
      // Download Failed
      //--------------------------------------------------
      onError: (message) async {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }

        if (!mounted) return;

        await PopupService.error(context, message);
      },
    );
  }

  //------------------------------------------------------
  // Delete Language
  //------------------------------------------------------

  Future<void> deleteLanguage() async {
    if (selectedLanguage == null) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${selectedLanguage!.name} removed.")),
    );

    // TODO:
    // Delete downloaded files
  }

  //------------------------------------------------------
  // UI
  //------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Learning Preferences")),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  //--------------------------------------------------
                  // Language
                  //--------------------------------------------------
                  LanguageDropdown(
                    languages: languages,

                    selectedId: selectedLanguageId,

                    onChanged: (value) {
                      setState(() {
                        selectedLanguageId = value;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  //--------------------------------------------------
                  // Download Card
                  //--------------------------------------------------
                  if (selectedLanguage != null)
                    DownloadLanguageCard(
                      language: selectedLanguage!,

                      onDownload: () {
                        downloadLanguage(selectedLanguage!);
                      },

                      onDelete: deleteLanguage,
                    ),

                  const SizedBox(height: 25),

                  //--------------------------------------------------
                  // Category
                  //--------------------------------------------------
                  CategoryDropdown(
                    categories: categories,

                    selectedId: selectedCategoryId,

                    onChanged: (value) {
                      setState(() {
                        selectedCategoryId = value;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  //--------------------------------------------------
                  // Difficulty
                  //--------------------------------------------------
                  DifficultyDropdown(
                    levels: levels,

                    selectedId: selectedDifficultyId,

                    onChanged: (value) {
                      setState(() {
                        selectedDifficultyId = value;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  //--------------------------------------------------
                  // Words Per Session
                  //--------------------------------------------------
                  DropdownButtonFormField<int>(
                    value: wordsPerSession,

                    decoration: const InputDecoration(
                      labelText: "Words Per Session",

                      prefixIcon: Icon(Icons.menu_book),

                      border: OutlineInputBorder(),
                    ),

                    items: sessionList.map((item) {
                      return DropdownMenuItem<int>(
                        value: item,

                        child: Text("$item Words"),
                      );
                    }).toList(),

                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        wordsPerSession = value;
                      });
                    },
                  ),

                  const SizedBox(height: 40),

                  //--------------------------------------------------
                  // Save Button
                  //--------------------------------------------------
                  SizedBox(
                    width: double.infinity,

                    height: 55,

                    child: ElevatedButton.icon(
                      onPressed: saving ? null : savePreference,

                      icon: saving
                          ? const SizedBox(
                              width: 20,

                              height: 20,

                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.save),

                      label: Text(saving ? "Saving..." : "SAVE PREFERENCES"),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }
}
