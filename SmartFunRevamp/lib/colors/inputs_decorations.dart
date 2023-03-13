import 'package:flutter/material.dart';

import 'colors.dart';

class CustomInputDecorations {
  static OutlineInputBorder k20RoundedCustomBlue = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide: const BorderSide(
      color: CustomColors.customBlue,
    ),
  );
  static OutlineInputBorder k20RoundedError = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide: const BorderSide(
      color: Colors.red,
    ),
  );
}
