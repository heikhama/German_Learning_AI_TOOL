import 'package:flutter/material.dart';

import '../models/app_page.dart';
import '../services/auth_service.dart';

import '../widgets/app_drawer.dart';

import 'home_screen.dart';
import 'vocabulary_screen.dart';
import 'practice_screen.dart';
import 'progress_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'login_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  AppPage currentPage = AppPage.home;

  //----------------------------------------------------------
  // All Pages
  //----------------------------------------------------------

  final List<Widget> pages = const [

    HomeScreen(),

    VocabularyScreen(),

    PracticeScreen(),

    ProgressScreen(),

    ProfileScreen(),

    SettingsScreen(),
  ];

  //----------------------------------------------------------

  int get currentIndex {

    switch (currentPage) {

      case AppPage.home:
        return 0;

      case AppPage.vocabulary:
        return 1;

      case AppPage.practice:
        return 2;

      case AppPage.progress:
        return 3;

      case AppPage.profile:
        return 4;

      case AppPage.settings:
        return 5;
    }
  }

  //----------------------------------------------------------

  String get title {

    switch (currentPage) {

      case AppPage.home:
        return "Home";

      case AppPage.vocabulary:
        return "Vocabulary";

      case AppPage.practice:
        return "Practice";

      case AppPage.progress:
        return "Progress";

      case AppPage.profile:
        return "Profile";

      case AppPage.settings:
        return "Settings";
    }
  }

  //----------------------------------------------------------

  void openPage(AppPage page) {

    setState(() {

      currentPage = page;

    });

  }

  //----------------------------------------------------------

  Future<void> logout() async {

    await AuthService.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(

      context,

      MaterialPageRoute(

        builder: (_) => const LoginScreen(),

      ),

      (route) => false,

    );

  }

  //----------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(title),

      ),

      drawer: AppDrawer(

        currentPage: currentPage,

        onPageSelected: openPage,

        onLogout: logout,

      ),

      body: IndexedStack(

        index: currentIndex,

        children: pages,

      ),
    );
  }
}