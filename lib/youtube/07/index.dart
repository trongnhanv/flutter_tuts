import 'package:basic_tuts/youtube/common_widget/debouncer.dart';
import 'package:flutter/material.dart';

class Chap07 extends StatefulWidget {
  const Chap07({Key? key}) : super(key: key);

  @override
  State<Chap07> createState() => _Chap07State();
}

class _Chap07State extends State<Chap07> {
  String name = "";
  final _textEditingController = TextEditingController();
  final _debouncer = Deboucer(ms: 500);

  void _handleChangeText(String text) {
    _debouncer.run(() {
      setState(() {
        name = text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        title: "Basic Tuts Chap 07",
        home: Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: _textEditingController,
                  onChanged: _handleChangeText,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'Enter your name'),
                ),
              ),
              if (name.isNotEmpty)
                Text(
                  'Hello, $name',
                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                ),
            ],
          )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _debouncer.stop();
  }
}
