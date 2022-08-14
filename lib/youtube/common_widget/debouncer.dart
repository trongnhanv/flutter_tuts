import 'dart:async';

import 'package:flutter/material.dart';

class Deboucer {
  final int ms;
  Timer? _timer;

  Deboucer({required this.ms});

  void run(VoidCallback callback) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: ms), callback);
  }

  void stop() {
    _timer?.cancel();
  }
}
