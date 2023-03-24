import 'package:flutter/material.dart';
import 'package:semnox/colors/gradients.dart';

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
