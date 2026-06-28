import 'package:flutter/material.dart';

import '../widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          //------------------------------------------------
          // Profile Card
          //------------------------------------------------

          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [

                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage(
                    "assets/images/avatar.png",
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Hydrogen Cloud",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "hydrogen@test.com",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          //------------------------------------------------
          // Account
          //------------------------------------------------

          SettingsTile(
            icon: Icons.person,
            title: "Edit Profile",
            onTap: () {},
          ),

          SettingsTile(
            icon: Icons.email,
            title: "Change Email",
            onTap: () {},
          ),

          SettingsTile(
            icon: Icons.lock,
            title: "Change Password",
            onTap: () {},
          ),

          SettingsTile(
            icon: Icons.photo_camera,
            title: "Change Avatar",
            onTap: () {},
          ),

          const SizedBox(height: 20),

          //------------------------------------------------
          // Preferences
          //------------------------------------------------

          SettingsTile(
            icon: Icons.language,
            title: "Language",
            onTap: () {},
          ),

          SettingsTile(
            icon: Icons.dark_mode,
            title: "Dark Theme",
            onTap: () {},
          ),

          const SizedBox(height: 20),

          //------------------------------------------------
          // About
          //------------------------------------------------

          SettingsTile(
            icon: Icons.info,
            title: "About",
            onTap: () {},
          ),

          SettingsTile(
            icon: Icons.description,
            title: "Privacy Policy",
            onTap: () {},
          ),

          const SizedBox(height: 25),

          //------------------------------------------------
          // Logout
          //------------------------------------------------

          SizedBox(
            width: 220,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
              ),
              onPressed: () {
                Navigator.pop(context);
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