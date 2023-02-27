import 'package:intl/intl.dart';

extension StringExtension on String? {
  bool isNullOrEmpty() {
    if (this == null || this!.isEmpty) {
      return true;
    }
    return false;
  }
}

extension DateTimeExtension on DateTime? {
  String formatDate(String format) {
    final formatter = DateFormat(format);
    if (this != null) {
      return formatter.format(this!);
    } else {
      return 'N/A';
    }
  }
}
