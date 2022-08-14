import 'package:basic_tuts/udemy/the_complete_guide/models/qa.dart';
import 'package:flutter/material.dart';

import './question.dart' as question_widget;
import './answer.dart' as answer_widget;

class Quiz extends StatelessWidget {
  final List<QA> qas;
  final int qaIndex;
  final void Function(int score) answerQuestion; // Trloi cau hoi

  const Quiz({
    Key? key,
    required this.qas,
    required this.qaIndex,
    required this.answerQuestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        question_widget.Question(
          questionText: qas[qaIndex].question,
        ),
        ...qas[qaIndex].answers.map((item) => answer_widget.Answer(
              answerText: item.text,
              selectHandler: () => answerQuestion(item.score),
            ))
        // question_widget.Question(
        //   questions[questionIndex]['questionText'],
        // ),
        // ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
        //     .map((answer) {
        //   return answer_widget.Answer(
        //       () => answerQuestion(answer['score']), answer['text']);
        // }).toList()
      ],
    );
  }
}
