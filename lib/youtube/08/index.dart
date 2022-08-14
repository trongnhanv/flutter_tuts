// ignore_for_file: avoid_print

import 'package:basic_tuts/youtube/common_widget/debouncer.dart';
import 'package:flutter/material.dart';

class Chap08 extends StatefulWidget {
  const Chap08({Key? key}) : super(key: key);

  @override
  State<Chap08> createState() => _Chap07State();
}

class _Chap07State extends State<Chap08> with WidgetsBindingObserver {
  // Theory
  // Lifecycle of Widget
  // 0. Contructor
  // 1. Init State: initState()
  // 2. Build: build() -> Đây là hàm render lại Widget
  // 3. Dispose: dispose()
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
  void initState() {
    super.initState();

    // Đăng ký Obsever để có thể check được Background/Forgeround Mode
    WidgetsBinding.instance!.addObserver(this);
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
        title: "Basic Tuts Chap 08",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Chapter 08"),
          ),
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
    WidgetsBinding.instance!.removeObserver(this);
    _debouncer.stop();
    _textEditingController.dispose(); // Dispose đi, để tránh tham chiếu vẫn còn
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // App đang chạy ngầm/chạy nền -> Tức là đang xài app bỗng tắt đi, hoặc mở app khác
      print("App is an Background Mode");
    } else if (state == AppLifecycleState.resumed) {
      // Được mở trở lại từ Background Mode
      print("App is an Foregounf Mode");
    }
  }
}
