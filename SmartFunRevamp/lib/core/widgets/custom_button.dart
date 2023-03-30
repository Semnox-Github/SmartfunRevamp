import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class CustomCancelButton extends StatelessWidget {
  const CustomCancelButton({super.key, required this.label, required this.onPressed});
  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: CustomGradients.linearGradient,
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
          child: MulishText(
            text: label,
            fontWeight: FontWeight.bold,
            fontColor: CustomColors.hardOrange,
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

  const CustomButton({
    super.key,
    required this.onTap,
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
        gradient: CustomGradients.linearGradient,
      ),
      margin: margin,
      child: TextButton(
        onPressed: onTap,
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

class CustomIconButton extends StatelessWidget {
  final Function() onTap;
  final String label;
  final double width;
  final EdgeInsets margin;
  final Widget icon;

  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.label,
    this.width = double.infinity,
    this.margin = const EdgeInsets.all(3),
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: CustomGradients.linearGradient,
      ),
      margin: margin,
      child: TextButton(
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10.0),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
