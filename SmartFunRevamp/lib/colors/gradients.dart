import 'package:flutter/material.dart';

class CustomGradients {
  static const LinearGradient linearGradient = LinearGradient(
    colors: [
      Color(0XFFFFA65E),
      Color(0XFFD43243),
    ],
  );
  static const LinearGradient disabledGradient = LinearGradient(
    colors: [
      Colors.grey,
      Colors.grey,
    ],
  );
  static const LinearGradient goldenGradient = LinearGradient(
    colors: [
      Color(0xFFFFF2AD),
      Color(0xFFFFA322),
    ],
  );
  static const LinearGradient skyBlueGradient = LinearGradient(
    colors: [
      Color(0xFF25E5FF),
      Color(0xFFAADBFF),
    ],
  );
  static const RadialGradient myFirstCircularGradient = RadialGradient(
    colors: [
      Color(0xFFF29C56),
      Color(0xFFD74C5A),
    ],
    center: Alignment.bottomRight,
    radius: 1.5,
  );
  static const RadialGradient silverCircularGradient = RadialGradient(
    colors: [
      Color(0xFFF4F4F4),
      Color(0xFFE9E9E9),
      Color(0xFF9697BB),
    ],
    center: Alignment.topRight,
    radius: 1.5,
  );
  static RadialGradient goldenCircularGradient = RadialGradient(
    colors: [
      Colors.yellow,
      Colors.orangeAccent,
      Colors.yellow.shade300,
    ],
    center: Alignment.topRight,
    radius: 1.5,
  );
  static RadialGradient platimunGradient = const RadialGradient(
    colors: [
      Color(0xFF58949C),
      Color(0xFFAADBFF),
      Color(0xFF125C84),
    ],
    center: Alignment.topRight,
    radius: 1.5,
  );
}
