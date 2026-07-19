import 'package:flutter/material.dart';

import '../models/word.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';
import '../models/dashboard_model.dart';
import '../services/download_service.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/banner_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/word_card.dart';
import '../widgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Word? currentWord;

  bool loading = true;

  UserModel? user;

  bool loadingProfile = true;

  DashboardModel? dashboard;

  bool loadingDashboard = true;

  @override
  void initState() {
    super.initState();

    loadProfile();
    loadWord();
    loadDashboard();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loadProfile();
  }

  Future<void> loadWord() async {
    try {
      final token = await AuthService.getToken();

      print("TOKEN : $token");

      final word = await ApiService.getRandomWord(token: token!);

      print("WORD : ${word.word}");

      if (!mounted) return;

      setState(() {
        currentWord = word;

        loading = false;
      });
    } catch (e) {
      print("LOAD WORD ERROR");

      print(e);

      if (!mounted) return;

      setState(() {
        loading = false;
      });
    }
  }

  Future<void> loadProfile() async {
    try {
      final profile = await AuthService.getProfile();

      if (!mounted) return;

      setState(() {
        user = profile;
        loadingProfile = false;
      });
    } catch (e) {
      debugPrint(e.toString());

      if (!mounted) return;

      setState(() {
        loadingProfile = false;
      });
    }
  }

  Future<void> loadDashboard() async {
  if (user == null) return;

    dashboard = await DownloadService.getDashboard(
      userId: user!.id,
      languageId: user!.learningLanguageId,
    );

    if (!mounted) return;

    setState(() {
      loadingDashboard = false;
    });
  }
  

  Widget buildRow(
  String title,
  String value,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          DashboardHeader(user: user),

          const SizedBox(height: 20),

          BannerCard(user: user),

          const SizedBox(height: 25),

          const SectionTitle(title: "Today's Progress"),

          Row(

  children: [

    StatCard(

      icon: Icons.menu_book,

      value: (dashboard?.wordsLearned ?? 0).toString(),

      title: "Words",

    ),

    StatCard(

      icon: Icons.school,

      value: "${dashboard?.accuracy ?? 0}%",


      title: "Accuracy",

    ),

    StatCard(

      icon:
          Icons.local_fire_department,

      value: (dashboard?.streak ?? 0).toString(),

      title: "Streak",

    ),

    StatCard(

      icon:
          Icons.local_fire_department,

      value: "${dashboard?.bestScore ?? 0}/10",

      title: "Streak",

    ),

    StatCard(

      icon:
          Icons.local_fire_department,

      value: "${dashboard?.lastScore ?? 0}/10",

      title: "Streak",

    ),

    StatCard(

      icon:
          Icons.local_fire_department,

      value: (dashboard?.testsTaken ?? 0).toString(),

      title: "Streak",

    ),

  ],

),

const SizedBox(height: 25),

const SectionTitle(
  title: "Practice Summary",
),

Card(

  child: Padding(

    padding:
        const EdgeInsets.all(18),

    child: Column(

      children: [

        buildRow(

          "Best Score",

          "${dashboard?.bestScore ?? 0}/10",

        ),

        const Divider(),

        buildRow(

          "Last Score",

          "${dashboard?.lastScore ?? 0}/10",

        ),

        const Divider(),

        buildRow(

          "Tests Taken",

          (dashboard?.testsTaken ?? 0)
              .toString(),

        ),

      ],

    ),

  ),

),

          const SizedBox(height: 30),

          const SectionTitle(title: "Today's Word"),

          // WordCard(word: currentWord!, onNext: loadWord),
    

          if (currentWord == null)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(20),

                child: Text("No word available", textAlign: TextAlign.center),
              ),
            )
          else
            WordCard(word: currentWord!, onNext: loadWord),
        ],
      ),
    );
  }
}
