import 'package:flutter/material.dart';
import 'package:semnox/colors/gradients.dart';

class GradientWrapper extends StatelessWidget {
  const GradientWrapper({
    Key? key,
    required this.child,
    this.gradient = CustomGradients.linearGradient,
  }) : super(key: key);
  final Widget child;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: child,
    );
  }
}
