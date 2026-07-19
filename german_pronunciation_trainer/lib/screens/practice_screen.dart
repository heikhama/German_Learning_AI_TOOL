// lib/screens/practice_screen.dart

import 'dart:async';

import 'package:flutter/material.dart';

import '../models/practice_question.dart';
import '../services/practice_service.dart';
import 'result_screen.dart';
import 'main_layout.dart';

class PracticeScreen extends StatefulWidget {
  
  final int userId;
  final int languageId;

  const PracticeScreen({
    super.key,
    required this.userId,
    required this.languageId,
  });

  @override
  State<PracticeScreen> createState() =>
      _PracticeScreenState();
}

class _PracticeScreenState
    extends State<PracticeScreen> {

  //----------------------------------------------------------
  // Variables
  //----------------------------------------------------------

  List<PracticeQuestion> questions = [];

  bool loading = true;

  bool answered = false;

  int currentQuestion = 0;

  int score = 0;

  int selectedIndex = -1;

  Timer? timer;

  int remainingSeconds = 600;

  //----------------------------------------------------------
  // Init
  //----------------------------------------------------------

  @override
  void initState() {
    super.initState();

    loadQuestions();
  }

  //----------------------------------------------------------
  // Dispose
  //----------------------------------------------------------

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }


  // Cancel Practice and Navigation

  Future<void> _cancelPractice() async {

  timer?.cancel();

  final shouldExit = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Cancel Practice"),
      content: const Text(
        "Are you sure you want to cancel this practice session?",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text("No"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text("Yes"),
        ),
      ],
    ),
  );

  if (shouldExit != true) {
    startTimer();
    return;
  }

  if (!mounted) return;

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => const MainLayout(),
    ),
    (route) => false,
  );
}

  //----------------------------------------------------------
  // Load Questions
  //----------------------------------------------------------

  Future<void> loadQuestions() async {
    try {
      questions = await PracticeService.getQuestions(
        widget.languageId,
      );

      loading = false;

      if (mounted) {
        setState(() {});
      }

      startTimer();
    } catch (e) {
      debugPrint(e.toString());

      if (!mounted) return;

      setState(() {
        loading = false;
      });
    }
  }

  //----------------------------------------------------------
  // Timer
  //----------------------------------------------------------

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {

        if (remainingSeconds == 0) {

          finishQuiz();

          return;

        }

        if (!mounted) return;

        setState(() {
          remainingSeconds--;
        });
      },
    );
  }

  //----------------------------------------------------------
  // Current Question
  //----------------------------------------------------------

  PracticeQuestion get question =>
      questions[currentQuestion];

  //----------------------------------------------------------
  // Time Text
  //----------------------------------------------------------

  String get timeText {

    final minutes =
        remainingSeconds ~/ 60;

    final seconds =
        remainingSeconds % 60;

    return "$minutes:${seconds.toString().padLeft(2, '0')}";

  }


    //----------------------------------------------------------
  // Select Answer
  //----------------------------------------------------------

  void selectAnswer(
    int index,
  ) {

    if (answered) {
      return;
    }

    answered = true;

    selectedIndex = index;

    if (question.options[index] ==
        question.correctAnswer) {

      score++;

    }

    setState(() {});

    Future.delayed(
      const Duration(
        milliseconds: 800,
      ),
      () {

        nextQuestion();

      },
    );

  }

  //----------------------------------------------------------
  // Next Question
  //----------------------------------------------------------

  void nextQuestion() {

    if (currentQuestion ==
        questions.length - 1) {

      finishQuiz();

      return;

    }

    setState(() {

      currentQuestion++;

      answered = false;

      selectedIndex = -1;

    });

  }

  //----------------------------------------------------------
  // Finish Quiz
  //----------------------------------------------------------

  Future<void> finishQuiz() async {

    timer?.cancel();

    final timeTaken =
        600 - remainingSeconds;

    try {

      await PracticeService.submitPractice(

        userId: widget.userId,

        languageId: widget.languageId,

        score: score,

        totalQuestions: questions.length,

        timeTaken: timeTaken,

      );

    } catch (e) {

      debugPrint(
        e.toString(),
      );

    }

    if (!mounted) {
      return;
    }

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
          score: score,
      totalQuestions: questions.length,
      timeTaken: timeTaken,
      userId: widget.userId,
      languageId: widget.languageId,
    ),
  ),
);

  

  }

  //----------------------------------------------------------
  // Build
  //----------------------------------------------------------

  @override
  Widget build(
    BuildContext context,
  ) {

    if (loading) {

      return const Scaffold(

        body: Center(

          child:
              CircularProgressIndicator(),

        ),

      );

    }

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Practice",
        ),

        centerTitle: true,

        actions: [
            IconButton(
            icon: const Icon(Icons.close),
            onPressed: _cancelPractice,
          ),
        ],

      ),

      body: Padding(

        padding:
            const EdgeInsets.all(
          20,
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Row(

              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [

                Text(

                  "Question ${currentQuestion + 1}/${questions.length}",

                  style:
                      const TextStyle(

                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),

                Text(

                  timeText,

                  style:
                      const TextStyle(

                    fontSize: 18,

                    color: Colors.red,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),

              ],

            ),

            const SizedBox(
              height: 20,
            ),

            LinearProgressIndicator(

              value:
                  (currentQuestion + 1) /
                      questions.length,

            ),

            const SizedBox(
              height: 40,
            ),

            Center(

              child: Text(

                question.word,

                textAlign:
                    TextAlign.center,

                style:
                    const TextStyle(

                  fontSize: 34,

                  fontWeight:
                      FontWeight.bold,

                ),

              ),

            ),

            const SizedBox(
              height: 12,
            ),

            const Center(

              child: Text(

                "Choose the correct meaning",

                style: TextStyle(

                  fontSize: 18,

                ),

              ),

            ),

            const SizedBox(
              height: 40,
            ),
            
            
            //--------------------------------------------------
            // Options
            //--------------------------------------------------

            Expanded(

              child: ListView.builder(

                itemCount: question.options.length,

                itemBuilder: (context, index) {

                  final option =
                      question.options[index];

                  Color backgroundColor =
                      Colors.white;

                  Color borderColor =
                      Colors.grey.shade300;

                  Color textColor =
                      Colors.black;

                  if (answered) {

                    //--------------------------------------------------
                    // Correct Answer
                    //--------------------------------------------------

                    if (option ==
                        question.correctAnswer) {

                      backgroundColor =
                          Colors.green.shade100;

                      borderColor =
                          Colors.green;

                      textColor =
                          Colors.green.shade900;

                    }

                    //--------------------------------------------------
                    // Wrong Selected Answer
                    //--------------------------------------------------

                    else if (index ==
                        selectedIndex) {

                      backgroundColor =
                          Colors.red.shade100;

                      borderColor =
                          Colors.red;

                      textColor =
                          Colors.red.shade900;

                    }

                  }

                  return Padding(

                    padding:
                        const EdgeInsets.only(
                      bottom: 15,
                    ),

                    child: InkWell(

                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),

                      onTap: () {

                        selectAnswer(index);

                      },

                      child: AnimatedContainer(

                        duration:
                            const Duration(
                          milliseconds: 250,
                        ),

                        padding:
                            const EdgeInsets.all(
                          18,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              backgroundColor,

                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),

                          border: Border.all(

                            color: borderColor,

                            width: 2,

                          ),

                        ),

                        child: Row(

                          children: [

                            CircleAvatar(

                              radius: 16,

                              child: Text(

                                String.fromCharCode(
                                  65 + index,
                                ),

                              ),

                            ),

                            const SizedBox(
                              width: 15,
                            ),

                            Expanded(

                              child: Text(

                                option,

                                style: TextStyle(

                                  fontSize: 18,

                                  color: textColor,

                                  fontWeight:
                                      FontWeight.w600,

                                ),

                              ),

                            ),

                          ],

                        ),

                      ),

                    ),

                  );

                },

              ),

            ),

            //--------------------------------------------------
            // Bottom Score
            //--------------------------------------------------

            Card(

              child: Padding(

                padding:
                    const EdgeInsets.all(
                  15,
                ),

                child: Row(

                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [

                    const Text(

                      "Current Score",

                      style: TextStyle(

                        fontSize: 18,

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),

                    Text(

                      "$score / ${questions.length}",

                      style: const TextStyle(

                        fontSize: 22,

                        fontWeight:
                            FontWeight.bold,

                        color: Colors.blue,

                      ),

                    ),

                  ],

                ),

              ),

            ),

            const SizedBox(height: 15),

            SizedBox(
  
                  width: double.infinity,
  
                  height: 50,
  
                  child: OutlinedButton.icon(
    
                  icon: const Icon(Icons.close),
    
                  label: const Text("Cancel Practice"),
    
                  onPressed: _cancelPractice,
                ),
            ),

          ],

        ),

      ),

    );

  }

}