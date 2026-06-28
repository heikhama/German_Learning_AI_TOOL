import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            SizedBox(height: 20),

            Icon(
              Icons.school,
              size: 80,
              color: Colors.blue,
            ),

            SizedBox(height: 20),

            Text(
              "German AI Trainer",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Version 4.0",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 30),

            Text(
              "Learn German vocabulary, pronunciation, grammar and speaking using Artificial Intelligence.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}