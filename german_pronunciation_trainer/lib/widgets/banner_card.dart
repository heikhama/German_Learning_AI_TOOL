import 'package:flutter/material.dart';

import '../core/app_images.dart';

class BannerCard extends StatelessWidget {

  const BannerCard({super.key});

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

            decoration: BoxDecoration(

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

          const Positioned(

            left: 20,

            bottom: 20,

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  "Speak German",

                  style: TextStyle(

                    color: Colors.white,

                    fontSize: 28,

                    fontWeight: FontWeight.bold,

                  ),

                ),

                SizedBox(height: 6),

                Text(

                  "Powered by AI",

                  style: TextStyle(

                    color: Colors.white,

                    fontSize: 16,

                  ),

                ),

              ],

            ),

          )

        ],

      ),

    );

  }

}