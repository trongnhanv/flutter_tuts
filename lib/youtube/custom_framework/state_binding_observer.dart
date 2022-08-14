// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

abstract class StateWithBindingObserver<T> extends State
    with WidgetsBindingObserver {
  void handleBackgroundMode() {
    print("App is an Background Mode");
  }

  void handleForgeroundMode() {
    print("App is an Foregound Mode");
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // App đang chạy ngầm/chạy nền -> Tức là đang xài app bỗng tắt đi, hoặc mở app khác
      handleBackgroundMode();
    } else if (state == AppLifecycleState.resumed) {
      // Được mở trở lại từ Background Mode
      handleForgeroundMode();
    }
  }
}
