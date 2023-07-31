import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';

final kCustomButtoBorderRadius = BorderRadius.circular(12.0);
ThemeData kCustomButtonTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0XFFFFA65E),
    secondary: Color(0XFFD43243),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: CustomColors.hardOrange,
      fontWeight: FontWeight.bold,
    ),
  ),
);
