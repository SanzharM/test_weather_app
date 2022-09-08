import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Utils {
  static DateTime? parseDate(String? date, {String format = 'yyyy-MM-ddTHH:mm:ss'}) {
    if (date == null) return null;
    try {
      return DateFormat(format).parse(date);
    } catch (e) {
      debugPrint('Unable to parse date ($date): $e');
    }
    return null;
  }
}
