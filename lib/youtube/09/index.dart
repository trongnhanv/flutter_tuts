import 'package:basic_tuts/youtube/common_widget/app_layout.dart';
import 'package:basic_tuts/youtube/custom_framework/state_binding_observer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chap09 extends StatefulWidget {
  const Chap09({Key? key}) : super(key: key);

  @override
  StateWithBindingObserver<Chap09> createState() => _Chap09State();
}

class _Chap09State extends StateWithBindingObserver<Chap09> {
  // Làm thế nào định nghĩa ngày/tháng
  DateTime now = DateTime.now();
  DateTime someDate = DateTime(1995, 06, 03);

  @override
  Widget build(BuildContext context) {
    // Format lại ngày tháng
    // var someDateFormat = DateFormat.yMMMd().format(someDate);
    var someDateFormat = DateFormat.yMMMd('vi_').format(someDate);

    return AppLayout(
        textTitle: 'Chapter 09',
        child: Center(
          child: Text(someDateFormat),
        ));
  }
}
