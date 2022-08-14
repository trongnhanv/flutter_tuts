import 'package:intl/intl.dart';

extension DateParsing on DateTime {
  String toFull() {
    return DateFormat.yMMMEd().format(this);
  }

  String toE() {
    return DateFormat.E().format(this);
  }

  bool isEqual(DateTime compareDate) {
    return day == compareDate.day &&
        month == compareDate.month &&
        year == compareDate.year;
  }
}
