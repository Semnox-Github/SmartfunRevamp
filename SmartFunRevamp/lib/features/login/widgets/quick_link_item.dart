import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class QuickLinkItem extends StatelessWidget {
  const QuickLinkItem({
    Key? key,
    required this.color,
    required this.imageUrl,
    required this.text,
    required this.onTap,
    required this.textColor,
  }) : super(key: key);
  final Color color;
  final String imageUrl;
  final String text;
  final Function() onTap;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 70.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: color,
            ),
            //padding: const EdgeInsets.all(13.0),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) {
                return const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 50.0,
                );
              },
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
        ],
      ),
    );
  }
}
