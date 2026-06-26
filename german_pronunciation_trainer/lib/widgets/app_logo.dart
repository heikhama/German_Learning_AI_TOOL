import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {

  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(

      children: [

        const Icon(
          Icons.school,
          size: 90,
          color: Colors.indigo,
        ),

        const SizedBox(height: 15),

        Text(

          "German AI Trainer",

          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),

        const SizedBox(height: 8),

        Text(

          "Learn German with AI",

          style: Theme.of(context)
              .textTheme
              .bodyMedium,
        ),
      ],
    );
  }
}