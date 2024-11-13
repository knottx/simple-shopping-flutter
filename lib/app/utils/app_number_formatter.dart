import 'package:intl/intl.dart';

class AppNumberFormatter {
  AppNumberFormatter._();

  static String? currency(num? number) {
    if (number == null) return null;
    return NumberFormat(',##0.00').format(number);
  }
}
