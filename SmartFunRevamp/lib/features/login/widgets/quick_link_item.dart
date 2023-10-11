import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class QuickLinkItem extends StatelessWidget {
  const QuickLinkItem({
    Key? key,
    required this.color,
    required this.imageUrl,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final Color color;
  final String imageUrl;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: color,
            ),
            padding: const EdgeInsets.all(13.0),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              errorWidget: (context, url, error) {
                return const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 50.0,
                );
              },
            ),
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
