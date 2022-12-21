import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/features/home/presentation/widgets/gradient_wrapper.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  const CustomBottomNavigationBarItem({
    Key? key,
    required this.currentIndex,
    required this.index,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final int currentIndex;
  final int index;
  final String icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GradientWrapper(
      gradient: currentIndex == index ? CustomGradients.linearGradient : CustomGradients.disabledGradient,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
          ),
          Text(text)
        ],
      ),
    );
  }
}
