import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

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
      return SplashScreenNotifier.getLanguageLabel('String is not a date');
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

extension NumExtension on num? {
  String toCurrency(String currency, String format) {
    if (this == null) {
      return '$currency 0.0 ';
    }
    final numberFormat = NumberFormat(format);
    return '$currency ${numberFormat.format(this)}';
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

extension MapKeyExtension on Map<dynamic, dynamic> {
  String getKey(String labelKey) {
    String? languageLabel = this[labelKey];
    if (languageLabel.isNullOrEmpty()) {
      Logger().e('Label not found for key: "$labelKey"');
      return labelKey;
    } else {
      return languageLabel.toString();
    }
  }
}
