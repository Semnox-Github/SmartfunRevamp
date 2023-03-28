import 'package:intl/intl.dart';

extension StringExtension on String? {
  bool isNullOrEmpty() {
    if (this == null || this!.isEmpty) {
      return true;
    }
    return false;
  }

  String cleanDate() {
    try {
      final date = DateTime.parse(this!);
      return DateFormat('MM-dd-yyyy').format(date);
    } catch (_) {
      return 'String is not a date';
    }
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

extension MapExtension on Map<dynamic, List> {
  String countItems() {
    int count = 0;
    forEach((key, list) {
      count += list.length;
    });
    return count.toString();
  }
}
