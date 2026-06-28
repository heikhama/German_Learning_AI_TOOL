import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';

import '../widgets/settings_tile.dart';

import 'login_screen.dart';
import 'settings/edit_profile_screen.dart';
import 'settings/change_email_screen.dart';
import 'settings/change_password_screen.dart';
import 'settings/avatar_screen.dart';
import 'settings/about_screen.dart';
// import 'settings/language_screen.dart';
import 'settings/theme_screen.dart';
import 'settings/privacy_policy_screen.dart';
import 'settings/learning_preferences_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserModel? user;

  bool loading = true;

  //------------------------------------------------------

  @override
  void initState() {
    super.initState();

    loadProfile();
  }

  //------------------------------------------------------

  Future<void> loadProfile() async {
    if (!mounted) return;

    setState(() {
      loading = true;
    });

    try {
      final profile = await AuthService.getProfile();

      if (!mounted) return;

      setState(() {
        user = profile;

        loading = false;
      });
    } catch (e) {
      debugPrint("Profile Error: $e");

      if (!mounted) return;

      setState(() {
        loading = false;
      });
    }
  }

  //------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //--------------------------------------------------
          // Profile Card
          //--------------------------------------------------
          loading
              ? const Padding(
                  padding: EdgeInsets.all(40),

                  child: CircularProgressIndicator(),
                )
              : Container(
                  width: double.infinity,

                  margin: const EdgeInsets.all(20),

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,

                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade200,

                        backgroundImage: user != null && user!.avatar.isNotEmpty
                            ? NetworkImage(
                                "${ApiService.baseUrl}${user!.avatar}"
                                "?t=${DateTime.now().millisecondsSinceEpoch}",
                              )
                            : null,

                        child: user == null || user!.avatar.isEmpty
                            ? const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              )
                            : null,
                      ),

                      const SizedBox(height: 15),

                      Text(
                        user?.name ?? "Guest User",

                        style: const TextStyle(
                          fontSize: 22,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        user?.email ?? "",

                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

          //--------------------------------------------------
          // Account
          //--------------------------------------------------
          SettingsTile(
            icon: Icons.person,
            title: "Edit Profile",

            onTap: () async {
              final updated = await Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );

              if (updated == true) {
                await loadProfile();
              }
            },
          ),

          SettingsTile(
            icon: Icons.email,

            title: "Change Email",

            onTap: () {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const ChangeEmailScreen()),
              );
            },
          ),

          SettingsTile(
            icon: Icons.lock,

            title: "Change Password",

            onTap: () {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
              );
            },
          ),

          SettingsTile(
            icon: Icons.photo_camera,
            title: "Change Avatar",

            onTap: () async {
              final updated = await Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const AvatarScreen()),
              );

              if (updated == true) {
                await loadProfile();
              }
            },
          ),

          const SizedBox(height: 20),

          //--------------------------------------------------
          // Preferences
          //--------------------------------------------------
          SettingsTile(
            icon: Icons.school,

            title: "Learning Preferences",

            // subtitle: user == null
            //     ? ""
            //     : "${user!.learningLanguage} • "
            //           "${user!.learningCategory} • "
            //           "${user!.learningLevel}",

            onTap: () async {
              final updated = await Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (_) => const LearningPreferencesScreen(),
                ),
              );

              if (updated == true) {
                await loadProfile();
              }
            },
          ),
          const SizedBox(height: 20),

          SettingsTile(
            icon: Icons.dark_mode,

            title: "Dark Theme",

            onTap: () {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const ThemeScreen()),
              );
            },
          ),

          const SizedBox(height: 20),

          //--------------------------------------------------
          // About
          //--------------------------------------------------
          SettingsTile(
            icon: Icons.info,

            title: "About",

            onTap: () {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const AboutScreen()),
              );
            },
          ),

          SettingsTile(
            icon: Icons.description,

            title: "Privacy Policy",

            onTap: () {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
              );
            },
          ),

          const SizedBox(height: 25),

          //--------------------------------------------------
          // Logout
          //--------------------------------------------------
          SizedBox(
            width: 220,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                await AuthService.logout();

                if (!mounted) return;

                Navigator.pushAndRemoveUntil(
                  context,

                  MaterialPageRoute(builder: (_) => const LoginScreen()),

                  (route) => false,
                );
              },

              icon: const Icon(Icons.logout),

              label: const Text("Logout"),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
