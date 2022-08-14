// ignore_for_file: deprecated_member_use

import 'package:basic_tuts/udemy/the_complete_guide/models/qa.dart';
import 'package:basic_tuts/udemy/the_complete_guide/widgets/quiz.dart';
import 'package:basic_tuts/udemy/the_complete_guide/widgets/result.dart';
import 'package:flutter/material.dart';

class TheCompleteGuideApp extends StatefulWidget {
  const TheCompleteGuideApp({Key? key}) : super(key: key);

  @override
  State<TheCompleteGuideApp> createState() => _TheCompleteGuideAppState();
}

class _TheCompleteGuideAppState extends State<TheCompleteGuideApp> {
  final List<QA> _qas = [
    QA(question: 'What\'s your favorite color?', answers: [
      Answer(text: 'Red', score: 10),
      Answer(text: 'Yellow', score: 5),
      Answer(text: 'Blue', score: 3),
      Answer(text: 'White', score: 1),
    ]),
    QA(question: 'What\'s your favorite animal?', answers: [
      Answer(text: 'Lion', score: 10),
      Answer(text: 'Falcon', score: 5),
      Answer(text: 'Shark', score: 3),
      Answer(text: 'Tiger', score: 1),
    ])
  ];

  int _qaIndex = 0;
  int _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _qaIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    // var aBool = true;
    // aBool = false;

    _totalScore += score;

    setState(() {
      _qaIndex = _qaIndex + 3;
    });
    print(_qaIndex);
    if (_qaIndex < _qas.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  Widget _buildBody() => _qaIndex < _qas.length
      ? Quiz(
          answerQuestion: _answerQuestion,
          qaIndex: _qaIndex,
          qas: _qas,
        )
      : Result(
          resultScore: _totalScore,
          resetHandler: _resetQuiz,
        );

  Widget _buildBodyWithButtons() => Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  foregroundColor: MaterialStateProperty.all(Colors.yellow)),
              onPressed: () {},
              child: const Text('Elevated Button')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.green, onPrimary: Colors.red),
              onPressed: () {},
              child: const Text('Elevated Button')),
          TextButton(
              style: TextButton.styleFrom(primary: Colors.pink),
              onPressed: () {},
              child: const Text('Text Button')),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                  primary: Colors.grey,
                  side: const BorderSide(color: Colors.green)),
              onPressed: () {},
              child: const Text('Outlined Button'))
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Quiz!!!'),
          ),
        ),
        body: _buildBody(),
      ),
    );
  }
}
