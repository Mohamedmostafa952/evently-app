import 'package:intl/intl.dart';

extension DateFormate on DateTime {
  String get getMonthFormDateTime {
    DateFormat formatter = DateFormat("MMMM");
    return formatter.format(this);
  }

  String get toFormattedYear {
    DateFormat formatter = DateFormat("dd-MM-yyyy");
    return formatter.format(this);
  }

  String get getTimeFormatted {
    DateFormat formatter = DateFormat("hh:mm a");
    return formatter.format(this);
  }
}
