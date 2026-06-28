import 'package:flutter/material.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() =>
      _ThemeScreenState();
}

class _ThemeScreenState
    extends State<ThemeScreen> {

  bool darkMode = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Theme",
        ),

      ),

      body: ListView(

        children: [

          SwitchListTile(

            title: const Text(
              "Dark Theme",
            ),

            subtitle: const Text(
              "Enable dark mode",
            ),

            value: darkMode,

            onChanged: (value) {

              setState(() {

                darkMode = value;

              });

            },

          ),

        ],

      ),

    );

  }

}