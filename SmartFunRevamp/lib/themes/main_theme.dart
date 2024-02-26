import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';

final kMainTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(color: CustomColors.customBlue),
  textTheme: GoogleFonts.mulishTextTheme(),
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

AppColors colors(context) => Theme.of(context).extension<AppColors>()!;

ThemeData getAppTheme(BuildContext context, HomePageCMSResponse cms) {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: CustomColors.customBlue),
    textTheme: GoogleFonts.mulishTextTheme(),
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
}

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color? color1;
  final Color? color2;
  final Color? color3;

  const AppColors({
    required this.color1,
    required this.color2,
    required this.color3,
  });

  @override
  AppColors copyWith({
    Color? color1,
    Color? color2,
    Color? color3,
  }) {
    return AppColors(
      color1: color1 ?? this.color1,
      color2: color2 ?? this.color2,
      color3: color3 ?? this.color3,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      color1: Color.lerp(color1, other.color1, t),
      color2: Color.lerp(color2, other.color2, t),
      color3: Color.lerp(color3, other.color3, t),
    );
  }
}
