import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';

final kMainTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(color: CustomColors.customBlue),
  textTheme: GoogleFonts.mulishTextTheme(),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    centerTitle: true,
    iconTheme: IconThemeData(color: CustomColors.customBlue),
    backgroundColor: CustomColors.customLigthBlue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    fillColor: Colors.transparent,
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        color: Colors.pink,
      ),
    ),
    //The normal state of the widget
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        color: Colors.black,
      ),
    ),
    //When the user clicks on the Widget
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        color: Colors.blue,
      ),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    ),
  ),
);
