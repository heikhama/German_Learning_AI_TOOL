import 'package:flutter/material.dart';

import '../core/app_images.dart';
import '../models/user_model.dart';

class BannerCard extends StatelessWidget {
  final UserModel? user;

  const BannerCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),

      child: Stack(
        children: [
          Image.asset(
            AppImages.germany,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          Container(
            height: 180,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ],
              ),
            ),
          ),

          Positioned(
            left: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Speak ${user?.learningLanguage ?? "German"}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Powered by AI",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}