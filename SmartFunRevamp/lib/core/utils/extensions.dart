import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/features/sign_up/pages/web_view_page.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:url_launcher/url_launcher.dart';

extension HexColor on Color {
  static Color fromHex(String? hexString) {
    if (hexString.isNullOrEmpty()) {
      return Colors.transparent;
    }
    if (hexString!.startsWith('#')) {
      hexString = hexString.substring(1);
    }
    //Note: the 8 char hex color values in cms are in RGBA format, flutter needs ARGB
    if (hexString.length == 8) {
      //i.e. 00EE00FF
      //taking the Alpha value "FF"
      String hexAlpha = hexString.substring(5, 7);
      //taking the RGB value "00EE00"
      String hexRGB = hexString.substring(0, 6);
      //Concatenating to ARGB hex value "FF00EE00"
      hexString = hexAlpha + hexRGB;
    }
    return Color(int.parse(hexString.padLeft(8, 'f'), radix: 16));
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

extension CMSMenuItemExtension on CMSMenuItem {
  void goToTarget(BuildContext context) {
    final cleanTarget = target?.replaceAll('sf:/', '') ?? '';
    Logger().i(cleanTarget.isURL);
    if (cleanTarget.isURL) {
      launchUrl(Uri.parse(cleanTarget));
    } else {
      switch (cleanTarget) {
        case '/webview':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return WebViewPage(url: targetUrl ?? '', title: displayName);
              },
            ),
          );
          break;
        default:
          bool isUrl = Uri.tryParse(target ?? '')?.hasAbsolutePath ?? false;
          if (isUrl) {
            Navigator.pushNamed(context, Routes.kPlayPage);
          } else {
            Navigator.pushNamed(context, cleanTarget);
          }
      }
    }
  }
}
