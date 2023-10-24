import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

extension HexColor on Color {
  static Color fromHex(String? hexString) {
    if (hexString.isNullOrEmpty()) {
      return Colors.red;
    }
    if (hexString!.startsWith('#')) {
      hexString = hexString.substring(1);
    }

    // Parse the hex color string to an integer
    int parsedColor = int.tryParse(hexString, radix: 16) ?? 0xFF000000;

    // Ensure the alpha value is set (default to fully opaque if not present)
    if (hexString.length == 6) {
      parsedColor |= 0xFF000000; // Add alpha channel
    }

    return Color(parsedColor);
  }
}

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

extension ListStringExtension on List<String>? {
  List<Color> getColorList() {
    if (this == null || this!.isEmpty) {
      return [CustomColors.hardOrange];
    }
    final colorList = this!.map((e) => HexColor.fromHex(e)).toList();
    if (colorList.length < 2) {
      colorList.add(CustomColors.hardOrange);
    }
    return colorList;
  }
}

extension ListExtension on List? {
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

extension ExceptionExtension on Exception {
  Failure handleException({
    String errorMessage = '',
    String errorMessage404 = 'Not Found',
  }) {
    if (errorMessage.isNotEmpty) {
      return ServerFailure(errorMessage);
    }

    if (this is DioException) {
      final exception = this as DioException;
      switch (exception.type) {
        case DioExceptionType.connectionError:
          return ClientFailure('No Internet Connection');
        case DioExceptionType.connectionTimeout:
          return ServerFailure('Server take too much time.');
        default:
          final message = json.decode(exception.response.toString());
          if (exception.response?.statusCode == 404) {
            return ServerFailure(SplashScreenNotifier.getLanguageLabel(errorMessage404));
          } else if (message != null) {
            return ServerFailure(SplashScreenNotifier.getLanguageLabel(message['data']));
          }
          return ServerFailure('Request Failed with error code ${exception.response?.statusCode}');
      }
    }
    return ServerFailure('Uknown Error');
  }
}
