import 'package:flutter/material.dart';

import '../models/app_page.dart';

class AppDrawer extends StatelessWidget {

  final AppPage currentPage;

  final ValueChanged<AppPage> onPageSelected;

  final VoidCallback onLogout;

  const AppDrawer({

    super.key,

    required this.currentPage,

    required this.onPageSelected,

    required this.onLogout,
  });

  Widget menu(

    BuildContext context,

    AppPage page,

    IconData icon,

    String title,

  ) {

    return ListTile(

      selected: currentPage == page,

      leading: Icon(icon),

      title: Text(title),

      onTap: () {

        Navigator.pop(context);

        onPageSelected(page);

      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Drawer(

      child: ListView(

        padding: EdgeInsets.zero,

        children: [

          const UserAccountsDrawerHeader(

            accountName:
                Text("Hydrogen"),

            accountEmail:
                Text("German AI Trainer"),

            currentAccountPicture:
                CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),

          menu(
            context,
            AppPage.home,
            Icons.home,
            "Home",
          ),

          menu(
            context,
            AppPage.vocabulary,
            Icons.menu_book,
            "Vocabulary",
          ),

          menu(
            context,
            AppPage.practice,
            Icons.record_voice_over,
            "Practice",
          ),

          menu(
            context,
            AppPage.progress,
            Icons.bar_chart,
            "Progress",
          ),

          menu(
            context,
            AppPage.profile,
            Icons.person,
            "Profile",
          ),

          menu(
            context,
            AppPage.settings,
            Icons.settings,
            "Settings",
          ),

          const Divider(),

          ListTile(

            leading:
                const Icon(Icons.logout),

            title:
                const Text("Logout"),

            onTap: () {

              Navigator.pop(context);

              onLogout();

            },
          ),
        ],
      ),
    );
  }
}