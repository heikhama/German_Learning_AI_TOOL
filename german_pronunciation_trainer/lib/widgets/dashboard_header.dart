import 'package:flutter/material.dart';

import '../core/app_images.dart';
import '../core/app_text.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(

      children: [

        Expanded(

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(

                "Hello Hydrogen 👋",

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

          radius: 32,

          backgroundColor: Colors.white,

          child: ClipOval(

            child: Image.asset(

              AppImages.avatar,

              width: 60,

              height: 60,

              fit: BoxFit.cover,

            ),

          ),

        ),

      ],

    );

  }

}