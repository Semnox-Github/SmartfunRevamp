import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';

class MulishText extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final cmsBody = ref.watch(cmsBodyStyleProvider);
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: HexColor.fromHex(cmsBody?.appTextColor),
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
        decorationColor: fontColor,
      ),
    );
  }
}
