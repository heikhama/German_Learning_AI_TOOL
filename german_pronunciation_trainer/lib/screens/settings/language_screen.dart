import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() =>
      _LanguageScreenState();
}

class _LanguageScreenState
    extends State<LanguageScreen> {

  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Language"),
      ),

      body: ListView(

        children: [

          RadioListTile(

            title: const Text("English"),

            value: "English",

            groupValue: selectedLanguage,

            onChanged: (value) {

              setState(() {

                selectedLanguage = value!;

              });

            },

          ),

          RadioListTile(

            title: const Text("German"),

            value: "German",

            groupValue: selectedLanguage,

            onChanged: (value) {

              setState(() {

                selectedLanguage = value!;

              });

            },

          ),

          RadioListTile(

            title: const Text("Hindi"),

            value: "Hindi",

            groupValue: selectedLanguage,

            onChanged: (value) {

              setState(() {

                selectedLanguage = value!;

              });

            },

          ),

        ],

      ),

    );

  }

}