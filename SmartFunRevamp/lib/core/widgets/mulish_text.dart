import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class MulishText extends StatelessWidget {
  const MulishText({
    Key? key,
    required this.text,
    this.fontWeight,
    this.fontColor,
    this.fontSize,
    this.textDecoration,
    this.textAlign = TextAlign.center,
  }) : super(key: key);
  final String text;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final double? fontSize;
  final TextDecoration? textDecoration;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      SplashScreenNotifier.getLanguageLabel(text),
      textAlign: textAlign,
      style: GoogleFonts.mulish(
        color: fontColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
        decorationColor: fontColor,
      ),
    );
  }
}
