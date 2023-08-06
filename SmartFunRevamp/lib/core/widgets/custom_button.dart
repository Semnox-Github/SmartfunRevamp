import 'package:flutter/material.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/themes/custom_button_theme.dart';

class CustomCancelButton extends StatelessWidget {
  const CustomCancelButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width = double.infinity,
  });
  final String label;
  final Function() onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          kCustomButtonTheme.colorScheme.primary,
          kCustomButtonTheme.colorScheme.secondary,
        ]),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(3),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              color: kCustomButtonTheme.textTheme.bodyMedium?.color,
              fontWeight: kCustomButtonTheme.textTheme.bodyMedium?.fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String label;
  final double width;
  final EdgeInsets margin;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.label,
    this.width = double.infinity,
    this.margin = const EdgeInsets.all(3),
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: kCustomButtoBorderRadius,
        gradient: LinearGradient(colors: [
          kCustomButtonTheme.colorScheme.primary,
          kCustomButtonTheme.colorScheme.secondary,
        ]),
      ),
      margin: margin,
      child: TextButton.icon(
        onPressed: onTap,
        icon: icon ?? const SizedBox.shrink(),
        label: Text(
          label,
          style: TextStyle(
            color: kCustomButtonTheme.textTheme.bodySmall?.color,
            fontWeight: kCustomButtonTheme.textTheme.bodySmall?.fontWeight,
          ),
        ),
      ),
    );
  }
}

class CustomDisabledButton extends StatelessWidget {
  final String label;
  final double width;
  final EdgeInsets margin;

  const CustomDisabledButton({
    super.key,
    required this.label,
    this.width = double.infinity,
    this.margin = const EdgeInsets.all(3),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: CustomGradients.disabledGradient,
      ),
      margin: margin,
      child: TextButton(
        onPressed: null,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
