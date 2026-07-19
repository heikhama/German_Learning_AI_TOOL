import 'package:flutter/material.dart';

import '../models/app_page.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';
import '../models/dashboard_model.dart';

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
  UserModel? user;
  bool loadingProfile = true;

  //----------------------------------------------------------
  // Load Profile
  //----------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await AuthService.getProfile();
      if (!mounted) return;
      setState(() {
        user = profile;
        loadingProfile = false;
      });
    } catch (e) {
      debugPrint("Profile Error: $e");
      if (!mounted) return;
      setState(() => loadingProfile = false);
    }
  }

  //----------------------------------------------------------
  // Page Title
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
  // Page Navigation
  //----------------------------------------------------------
  void openPage(AppPage page) {
    setState(() => currentPage = page);
  }

  Future<void> logout() async {
    await AuthService.logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  //----------------------------------------------------------
  // Build
  //----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: Drawer(
        child: Column(
          children: [
            _buildDrawerHeader(), // ✅ Profile header here
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("Home"),
                    onTap: () {
                      Navigator.pop(context);        // ✅ close drawer
                      openPage(AppPage.home);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text("Vocabulary"),
                    onTap: () {
                        Navigator.pop(context);        // ✅ close drawer
          
                       openPage(AppPage.vocabulary);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.school),
                    title: const Text("Practice"),
                    onTap: () {
                      Navigator.pop(context);        // ✅ close drawer
                      
                      openPage(AppPage.practice);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.bar_chart),
                    title: const Text("Progress"),
                    onTap: (){
                      Navigator.pop(context);        // ✅ close drawer
                      
                       openPage(AppPage.progress);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Profile"),
                    onTap: () {
                      Navigator.pop(context);        // ✅ close drawer
                      
                       openPage(AppPage.profile);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Settings"),
                    onTap: () {
                      Navigator.pop(context);        // ✅ close drawer
                      
                       openPage(AppPage.settings);
                    },
                  ),
                //   ListTile(
                //   leading: const Icon(Icons.school),
                //   title: const Text("Settings"),
                //   onTap: () async {
                //     Navigator.pop(context);
                //     final updated = await Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (_) => const SettingsScreen()),
                //     );
                //     if (updated == true) {
                //       _loadProfile(); // refresh after settings change
                //       setState(() => currentPage = AppPage.home);
                //     }
                //   },
                // ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Logout"),
                    onTap: logout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onDrawerChanged: (isOpen){
        if(isOpen){
          _loadProfile(); // ✅ reload profile when drawer opens
        }
      },
      body: _buildPage(),
    );
  }

  //----------------------------------------------------------
  // Drawer Header with Profile
  //----------------------------------------------------------
  Widget _buildDrawerHeader() {
    if (loadingProfile) {
      return const DrawerHeader(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return UserAccountsDrawerHeader(
      currentAccountPicture: CircleAvatar(
        backgroundImage: (user != null && user!.avatar.isNotEmpty)
            ? NetworkImage("${ApiService.baseUrl}${user!.avatar}?t=${DateTime.now().millisecondsSinceEpoch}")
            : null,
        child: (user == null || user!.avatar.isEmpty)
            ? const Icon(Icons.person, size: 40)
            : null,
      ),
      accountName: Text(user?.name ?? "Guest User"),
      accountEmail: Text(
        "${user?.learningLanguage ?? "English"} AI Trainer",
        style: const TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }

  //----------------------------------------------------------
  // Dynamic Page Builder
  //----------------------------------------------------------
  Widget _buildPage() {
    switch (currentPage) {
      case AppPage.home:
        return const HomeScreen();
      case AppPage.vocabulary:
        return const VocabularyScreen();
      case AppPage.practice:
          if (loadingProfile || user == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
          }

          return PracticeScreen(
          userId: user!.id,
          languageId: user!.learningLanguageId,
        );
      case AppPage.progress:
        return const ProgressScreen();
      case AppPage.profile:
        return const ProfileScreen();
      case AppPage.settings:
        return const SettingsScreen();
    }
  }
}
