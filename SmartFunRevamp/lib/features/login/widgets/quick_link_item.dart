import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuickLinkItem extends StatelessWidget {
  const QuickLinkItem({
    Key? key,
    required this.color,
    required this.image,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final Color color;
  final String image;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: color,
            ),
            padding: const EdgeInsets.all(13.0),
            child: SvgPicture.asset('assets/home/$image.svg'),
          ),
          const SizedBox(height: 10.0),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
