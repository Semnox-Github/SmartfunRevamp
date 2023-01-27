import 'package:flutter/material.dart';
import 'package:semnox/colors/gradients.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String label;
  final double width;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.label,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: CustomGradients.linearGradient,
      ),
      margin: const EdgeInsets.all(3),
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
