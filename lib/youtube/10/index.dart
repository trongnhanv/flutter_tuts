import 'package:basic_tuts/youtube/common_widget/app_layout.dart';
import 'package:basic_tuts/youtube/common_widget/text_field.dart';
import 'package:basic_tuts/youtube/custom_framework/state_binding_observer.dart';
import 'package:flutter/material.dart';

class Chap10 extends StatefulWidget {
  const Chap10({Key? key}) : super(key: key);

  @override
  StateWithBindingObserver<Chap10> createState() => _Chap10State();
}

class _Chap10State extends StateWithBindingObserver<Chap10> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isSnackbarActive = false;

  @override
  Widget build(BuildContext context) {
    return AppLayout(child: Builder(builder: (context) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Chapter 10 - Create Basic Layout',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const OutlinedDecoration(textLabel: 'Content'),
                controller: _contentController,
                maxLines: 2,
                keyboardType: TextInputType.multiline,
                onChanged: (text) {
                  // setState(() {
                  //   _content = text;
                  // });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const OutlinedDecoration(textLabel: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  // setState(() {
                  //   _amount = text;
                  // });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              // Text('Content is: $content & amount is: $amount'),
              ElevatedButton(
                onPressed: () {
                  if (_isSnackbarActive) {
                    return;
                  }
                  _isSnackbarActive = true;
                  var content = _contentController.text;
                  var amount = double.tryParse(_amountController.text) ?? 0;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                        SnackBar(
                          content: Text("Content: $content & amount: $amount"),
                        ),
                      )
                      .closed
                      .then((value) {
                    _isSnackbarActive = false;
                  });
                },
                child: const Text('Insert Transaction'),
              )
            ],
          ));
    }));
  }
}
