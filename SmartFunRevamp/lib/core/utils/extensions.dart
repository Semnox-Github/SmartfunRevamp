import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

extension HexColor on Color {
  static Color? fromHex(String? hexString) {
    if (hexString.isNullOrEmpty()) {
      return null;
    }
    hexString = hexString?.replaceFirst('#', '');
    //Note: the 8 char hex color values in cms are in RGBA format, flutter needs ARGB
    if (hexString?.length == 8) {
      //i.e. FFFFFF00
      //taking the A part "00"
      String hexFirst = hexString!.substring(5, 7);
      //taking the RGB part "FFFFFF"
      String hexStringFinal = hexString.substring(0, 6);
      //Concatenating to ARGB hex value "00FFFFFF"
      hexString = hexFirst + hexStringFinal;
    }
    final buffer = StringBuffer();
    if (hexString?.length == 5 || hexString?.length == 6) buffer.write('ff');
    buffer.write(hexString);

    return Color(int.parse(buffer.toString(), radix: 16));
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
