import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';

final kMainTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(color: CustomColors.customBlue),
  textTheme: GoogleFonts.mulishTextTheme(),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    fillColor: Colors.transparent,
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        color: Colors.black,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        color: Colors.black,
      ),
    ),
  ),
);
