import 'package:flutter/material.dart';

import 'practice_screen.dart';
import 'main_layout.dart';


class ResultScreen extends StatelessWidget {
  final int score;

  final int totalQuestions;

  final int timeTaken;

  final int userId;

  final int languageId;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.timeTaken,
    required this.userId,
    required this.languageId,
  });

  //----------------------------------------------------------
  // Percentage
  //----------------------------------------------------------

  double get percentage =>
      (score / totalQuestions) * 100;

  //----------------------------------------------------------
  // Performance Text
  //----------------------------------------------------------

  String get performance {
    if (percentage >= 90) {
      return "Excellent 🎉";
    }

    if (percentage >= 75) {
      return "Very Good 👏";
    }

    if (percentage >= 60) {
      return "Good 👍";
    }

    if (percentage >= 40) {
      return "Keep Practicing 💪";
    }

    return "Needs Improvement";
  }

  //----------------------------------------------------------
  // Performance Color
  //----------------------------------------------------------

  Color get performanceColor {
    if (percentage >= 90) {
      return Colors.green;
    }

    if (percentage >= 75) {
      return Colors.blue;
    }

    if (percentage >= 60) {
      return Colors.orange;
    }

    return Colors.red;
  }

  //----------------------------------------------------------
  // Time Format
  //----------------------------------------------------------

  String get formattedTime {
    final minutes = timeTaken ~/ 60;

    final seconds = timeTaken % 60;

    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Practice Result",
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(
          25,
        ),

        child: Column(
          children: [

            const SizedBox(
              height: 30,
            ),

            CircleAvatar(
              radius: 60,
              backgroundColor:
                  performanceColor.withOpacity(
                0.15,
              ),

              child: Icon(
                Icons.emoji_events,
                size: 70,
                color: performanceColor,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            Text(
              performance,

              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: performanceColor,
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(
                  20,
                ),

                child: Column(
                  children: [

                    buildRow(
                      "Score",
                      "$score / $totalQuestions",
                    ),

                    const Divider(),

                    buildRow(
                      "Percentage",
                      "${percentage.toStringAsFixed(0)} %",
                    ),

                    const Divider(),

                    buildRow(
                      "Time",
                      formattedTime,
                    ),

                  ],
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              height: 50,

              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.refresh,
                ),

                label: const Text(
                  "Practice Again",
                ),

                onPressed: () {
  
                  Navigator.pushReplacement(
                    
                    context,
    
                      MaterialPageRoute(
                          
                          builder: (_) => PracticeScreen(
                          
                          userId: userId,
                          
                          languageId: languageId,
      
                      ),
                    ),
                  );
                },

              ),
            ),

            const SizedBox(
              height: 15,
            ),

            SizedBox(
              width: double.infinity,

              height: 50,

              child: OutlinedButton.icon(

                icon: const Icon(
                  Icons.home,
                ),

                label: const Text(
                  "Back to Dashboard",
                ),

                onPressed: () {
                  
                  Navigator.pushAndRemoveUntil(
    
                        context,
                        MaterialPageRoute(
                        builder: (_) => const MainLayout(),
                      ),
                    (route) => false,
                  );
                },

              ),
            ),

            const SizedBox(
              height: 30,
            ),

          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------
  // Result Row
  //----------------------------------------------------------

  Widget buildRow(
    String title,
    String value,
  ) {

    return Padding(

      padding:
          const EdgeInsets.symmetric(
        vertical: 10,
      ),

      child: Row(

        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

        children: [

          Text(
            title,

            style: const TextStyle(
              fontSize: 18,
            ),
          ),

          Text(
            value,

            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),

    );

  }

}