import 'package:flutter/material.dart';

import '../models/word.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';

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

  @override
  void initState() {
    super.initState();

    loadProfile();
    loadWord();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loadProfile();
  }

  Future<void> loadWord() async {
    final word = await ApiService.getRandomWord();

    if (!mounted) return;

    setState(() {
      currentWord = word;

      loading = false;
    });
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

          const Row(
            children: [
              StatCard(icon: Icons.menu_book, value: "258", title: "Words"),

              StatCard(icon: Icons.school, value: "92%", title: "Accuracy"),

              StatCard(
                icon: Icons.local_fire_department,

                value: "15",

                title: "Streak",
              ),
            ],
          ),

          const SizedBox(height: 30),

          const SectionTitle(title: "Today's Word"),

          WordCard(word: currentWord!, onNext: loadWord),
        ],
      ),
    );
  }
}
