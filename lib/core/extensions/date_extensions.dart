import 'package:intl/intl.dart';

extension DateFormate on DateTime {
  String get getMonthFormDateTime {
    DateFormat formatter = DateFormat("MMMM");
    return formatter.format(this);
  }
}
