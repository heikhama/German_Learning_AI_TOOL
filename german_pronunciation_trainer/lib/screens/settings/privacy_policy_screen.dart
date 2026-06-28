import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [

            Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Effective Date: 28 June 2026",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            Divider(height: 40),

            Text(
              "1. Introduction",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "German AI Trainer is an AI-powered language learning application "
              "designed to help users improve their German vocabulary, pronunciation, "
              "grammar and speaking skills.",
            ),

            SizedBox(height: 25),

            Text(
              "2. Information We Collect",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "• Full Name\n"
              "• Email Address\n"
              "• Password (encrypted)\n"
              "• Avatar (optional)\n"
              "• Learning Progress\n"
              "• Pronunciation Scores\n"
              "• Device Information",
            ),

            SizedBox(height: 25),

            Text(
              "3. How We Use Your Information",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "We use your information to authenticate your account, save "
              "learning progress, personalize AI recommendations, improve "
              "our services, and provide customer support.",
            ),

            SizedBox(height: 25),

            Text(
              "4. AI Services",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Artificial Intelligence is used to evaluate pronunciation, "
              "generate exercises, explain grammar and recommend vocabulary.",
            ),

            SizedBox(height: 25),

            Text(
              "5. Data Security",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Passwords are securely hashed. Authentication uses JWT tokens. "
              "Your personal information is stored securely and access is "
              "restricted to authorized systems.",
            ),

            SizedBox(height: 25),

            Text(
              "6. Email Verification",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Email verification is required when registering or changing "
              "your email address to help protect your account.",
            ),

            SizedBox(height: 25),

            Text(
              "7. Your Rights",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "You may update your profile, change your password, change "
              "your email address, upload a new avatar, or request deletion "
              "of your account.",
            ),

            SizedBox(height: 25),

            Text(
              "8. Contact",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "German AI Trainer\n"
              "Email: support@germanaitrainer.com",
            ),

            SizedBox(height: 40),

            Center(
              child: Text(
                "© 2026 German AI Trainer\nAll Rights Reserved",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}