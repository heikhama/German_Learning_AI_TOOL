import 'package:flutter/material.dart';

import 'config/app_theme.dart';
import 'screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'providers/user_provider.dart';

void main() {
  runApp(const GermanAITrainerApp());
}

class GermanAITrainerApp extends StatelessWidget {
  const GermanAITrainerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "German AI Trainer",
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}