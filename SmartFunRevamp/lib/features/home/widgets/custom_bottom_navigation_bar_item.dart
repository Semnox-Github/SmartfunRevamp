import 'package:flutter/material.dart';

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
  final Widget icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        Text(
          text,
          style: TextStyle(
            color: currentIndex == index ? Colors.white : Colors.grey,
          ),
        ),
      ],
    );
  }
}
