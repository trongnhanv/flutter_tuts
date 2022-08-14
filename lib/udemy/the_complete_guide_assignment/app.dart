import 'package:basic_tuts/udemy/the_complete_guide_assignment/widgets/text.dart';
import 'package:basic_tuts/udemy/the_complete_guide_assignment/widgets/text_control.dart';
import 'package:flutter/material.dart';

class TheCompleteGuideAssignmentApp extends StatefulWidget {
  const TheCompleteGuideAssignmentApp({Key? key}) : super(key: key);

  @override
  State<TheCompleteGuideAssignmentApp> createState() =>
      _TheCompleteGuideAssignmentAppState();
}

class _TheCompleteGuideAssignmentAppState
    extends State<TheCompleteGuideAssignmentApp> {
  String text = 'SomeText';

  void _changeText() {
    setState(() {
      text = DateTime.now().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Assignment App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(text: text),
              TextControl(pressHanler: _changeText)
            ],
          ),
        ),
      ),
    );
  }
}
