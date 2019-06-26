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
}

class FormatDate {
  final _value;

  const FormatDate._internal(this._value);

  toString() => _value;

  static const ddMMyyyy = const FormatDate._internal('dd-MM-yyyy');
  static const EEEEddMMyyyy = const FormatDate._internal('EEEE dd-MM-yyyy');
}
