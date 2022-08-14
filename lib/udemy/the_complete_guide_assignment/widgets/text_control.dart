import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final void Function()? pressHanler;
  const TextControl({Key? key, required this.pressHanler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Change Text'),
      onPressed: pressHanler,
    );
  }
}
