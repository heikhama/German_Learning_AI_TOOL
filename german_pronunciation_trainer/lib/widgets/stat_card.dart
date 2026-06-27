import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class StatCard extends StatelessWidget {

  final IconData icon;

  final String value;

  final String title;

  const StatCard({

    super.key,

    required this.icon,

    required this.value,

    required this.title,

  });

  @override
  Widget build(BuildContext context) {

    return Expanded(

      child: Container(

        margin: const EdgeInsets.all(6),

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius: BorderRadius.circular(18),

          boxShadow: [

            BoxShadow(

              color: Colors.black12,

              blurRadius: 10,

            ),

          ],

        ),

        child: Column(

          children: [

            Icon(

              icon,

              color: AppColors.primary,

              size: 32,

            ),

            const SizedBox(height:10),

            Text(

              value,

              style: const TextStyle(

                fontSize:24,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height:4),

            Text(title),

          ],

        ),

      ),

    );

  }

}