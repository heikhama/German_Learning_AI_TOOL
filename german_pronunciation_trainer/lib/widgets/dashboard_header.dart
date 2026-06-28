import 'package:flutter/material.dart';

import '../core/app_text.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class DashboardHeader extends StatelessWidget {
  final UserModel? user;

  const DashboardHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello ${user?.name ?? "Guest"} 👋",
                style: AppText.heading,
              ),

              const SizedBox(height: 6),

              Text(
                "Learn German with Artificial Intelligence",
                style: AppText.subtitle,
              ),
            ],
          ),
        ),

        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey.shade200,
          backgroundImage:
              user == null || user!.avatar.isEmpty
                  ? const AssetImage(
                      "assets/images/avatar.png",
                    ) as ImageProvider
                  : NetworkImage(
                      "${ApiService.baseUrl}${user!.avatar}"
                      "?t=${DateTime.now().millisecondsSinceEpoch}",
                    ),
        ),
      ],
    );
  }
}