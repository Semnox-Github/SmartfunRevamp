import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox_core/generator/fonts.generator.dart';

import '../core/domain/entities/splash_screen/home_page_cms_response.dart';

final kMainTheme = ThemeData(
  canvasColor: Colors.blue.shade200,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(color: CustomColors.customBlue),
  textTheme: GoogleFonts
      .mulishTextTheme(), //.apply(), //generateTextTheme(Colors.white),
  //GoogleFonts.mulishTextTheme().apply(),
  radioTheme: RadioThemeData(
    fillColor:
        MaterialStateColor.resolveWith((states) => CustomColors.hardOrange),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    centerTitle: true,
    iconTheme: IconThemeData(color: CustomColors.customBlue),
    backgroundColor: CustomColors.customLigthBlue,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.vertical(
    //     bottom: Radius.circular(20),
    //   ),
    // ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey),
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
        color: Colors.white,
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

///AppColors colors(context) => Theme.of(context).extension<AppColors>()!;

ThemeData getAppTheme(BuildContext context, ThemeData themeData) {
  return themeData;
}

AppBarTheme generateAppBarTheme(Color color) {
  return AppBarTheme(
    backgroundColor: color,
    elevation: 0,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );
}

TextTheme generateTextTheme(Color color) {
  double factor = 1.0;
  // Color color = Colors.black;
  return TextTheme(
    headline1: TextStyle(
      fontFamily: FontFamily.gothamRounded,
      package: "semnox_core",
      fontWeight: FontWeight.w700,
      fontSize: 56 * factor,
      height: 67.2 / 56.0,
      color: color,
    ),
    headline2: TextStyle(
      fontFamily: FontFamily.gothamRounded,
      package: "semnox_core",
      fontWeight: FontWeight.w700,
      fontSize: 48 * factor,
      height: 57.6 / 48,
      color: color,
    ),
    headline3: TextStyle(
      fontFamily: FontFamily.gothamRounded,
      package: "semnox_core",
      fontWeight: FontWeight.w700,
      fontSize: 40 * factor,
      height: 48 / 40,
      color: color,
    ),
    headline4: TextStyle(
      fontFamily: FontFamily.gothamRounded,
      package: "semnox_core",
      fontSize: 32 * factor,
      height: 38.4 / 32,
      color: color,
    ),
    headline5: TextStyle(
      fontFamily: FontFamily.gothamRounded,
      package: "semnox_core",
      fontWeight: FontWeight.w700,
      fontSize: 24 * factor,
      height: 40 / 24,
      color: color,
    ),
    headline6: TextStyle(
      fontFamily: FontFamily.gothamRounded,
      package: "semnox_core",
      fontWeight: FontWeight.w700,
      fontSize: 20 * factor,
      height: 24 / 20,
      color: color,
    ),
    subtitle1: TextStyle(
      fontFamily: FontFamily.gothamRounded,
      package: "semnox_core",
      fontWeight: FontWeight.w400,
      fontSize: 20 * factor,
      height: 24 / 20,
      color: color,
    ),
    subtitle2: TextStyle(
      fontFamily: FontFamily.gothamRounded,
      package: "semnox_core",
      fontWeight: FontWeight.w400,
      fontSize: 20 * factor,
      height: 24 / 20,
      color: color,
    ),
    bodyText1: GoogleFonts.rubik(
      fontWeight: FontWeight.w500,
      color: color,
    ),
    bodyText2: GoogleFonts.rubik(
      fontWeight: FontWeight.w400,
      color: color,
    ),
    caption: GoogleFonts.rubik(
      fontWeight: FontWeight.w400,
      fontSize: 14.0 * factor,
      color: color,
    ),
    button: GoogleFonts.rubik(
      fontWeight: FontWeight.w500,
      fontSize: 20 * factor,
      color: color,
    ),
    overline: GoogleFonts.rubik(
      fontSize: 12 * factor,
      fontWeight: FontWeight.w400,
      color: color,
    ),
  );
}

ThemeData setAppTheme(cmsBody) {
  print(" cms background");
  print(cmsBody?.popupBackGroundColor ?? 'red');
  return ThemeData(
    canvasColor: HexColor.fromHex(cmsBody.popupBackGroundColor ?? "#ffffff"),
    //  primaryColor: Colors.lightBlue,
    useMaterial3: true,
    scaffoldBackgroundColor:
        HexColor.fromHex(cmsBody.appBackGroundColor ?? "#ffffff"),
    iconTheme: IconThemeData(
        color: HexColor.fromHex(
            cmsBody.appTextColor ?? "#ffffff")), //CustomColors.customBlue
    textTheme: GoogleFonts.mulishTextTheme()
        .apply(bodyColor: Colors.white), //generateTextTheme(Colors.white),
    //GoogleFonts.mulishTextTheme().apply(),
    radioTheme: RadioThemeData(
      fillColor:
          MaterialStateColor.resolveWith((states) => CustomColors.hardOrange),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      centerTitle: true,
      iconTheme: IconThemeData(color: CustomColors.customBlue),
      backgroundColor: CustomColors.customLigthBlue,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     bottom: Radius.circular(20),
      //   ),
      // ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle:
          TextStyle(color: HexColor.fromHex(cmsBody.appTextColor ?? "#ffffff")),
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
        borderSide: BorderSide(
          color: HexColor.fromHex(cmsBody.appTextColor ?? "#ffffff"),
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
}
