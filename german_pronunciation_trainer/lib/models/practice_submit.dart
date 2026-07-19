import 'answer.dart';

class PracticeSubmit {

  final int languageId;

  final int timeTaken;

  final List<Answer> answers;

  const PracticeSubmit({

    required this.languageId,

    required this.timeTaken,

    required this.answers,

  });

  Map<String, dynamic> toJson() {

    return {

      "language_id": languageId,

      "time_taken": timeTaken,

      "answers":

          answers

              .map(

                (e) => e.toJson(),

              )

              .toList(),

    };

  }

}