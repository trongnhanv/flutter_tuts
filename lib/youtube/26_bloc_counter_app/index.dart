import 'package:flutter/material.dart';

class CounterApplication extends StatelessWidget {
  const CounterApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter App with BLoC',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Counter App with BLoC'),
        ),
        body: const Center(
          child: Text('Number: ${0}'),
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            backgroundColor: Colors.red,
            child: const Icon(Icons.remove),
            onPressed: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {},
          )
        ]),
      ),
    );
  }
}
