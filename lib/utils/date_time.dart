import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtil {
  static String getDayOfWeek(DateTime date) {
    String dateOfWeek = '';
    switch (date.weekday) {
      case 1:
        dateOfWeek = 'Thứ 2';
        break;
      case 2:
        dateOfWeek = 'Thứ 3';
        break;
      case 3:
        dateOfWeek = 'Thứ 4';
        break;
      case 4:
        dateOfWeek = 'Thứ 5';
        break;
      case 5:
        dateOfWeek = 'Thứ 6';
        break;
      case 6:
        dateOfWeek = 'Thứ 7';
        break;
      case 7:
        dateOfWeek = 'Chủ nhật';
        break;
    }

    return dateOfWeek;
  }

  static String toMillisecondsSinceEpoch(
      BuildContext context, DateTime date, TimeOfDay time) {
    String from =
        '${DateFormat(FormatDate.yyyyMMdd.toString()).format(date)} ${time.format(context)}:00';
    int millisecondsSinceEpoch = DateTime.parse(from).millisecondsSinceEpoch;
    return '$millisecondsSinceEpoch';
  }

  static String toDate(int millisecondsSinceEpoch) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    var format = DateFormat(FormatDate.ddMMyyyyHHmm.toString());
    var dateString =
        '${DateTimeUtil.getDayOfWeek(date)}, ${format.format(date)}';
    return dateString;
  }
}

class FormatDate {
  final _value;

  const FormatDate._internal(this._value);

  toString() => _value;

  static const yyyyMMdd = const FormatDate._internal('yyyy-MM-dd');
  static const ddMMyyyy = const FormatDate._internal('dd/MM/yyyy');
  static const ddMMyyyyHHmm = const FormatDate._internal('dd/MM/yyyy hh:mm');
  static const EEEEddMMyyyy = const FormatDate._internal('EEEE dd/MM/yyyy');
  static const EEEEddMMyyyyhhmm =
      const FormatDate._internal('EEEE dd/MM/yyyy hh:mm');
}
