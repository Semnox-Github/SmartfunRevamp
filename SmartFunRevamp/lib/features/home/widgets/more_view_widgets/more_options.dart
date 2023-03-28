import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({
    super.key,
    required this.iconPath,
    required this.iconBgColor,
    required this.onTap,
    required this.title,
    required this.desc,
  });
  final String iconPath;
  final Color iconBgColor;
  final Function() onTap;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: CustomColors.customLigthGray,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              'assets/home/$iconPath.png',
              height: 36.0,
              width: 36.0,
            ),
          ),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MulishText(
                text: title,
                fontWeight: FontWeight.bold,
                fontColor: CustomColors.customPantone,
                fontSize: 16.0,
              ),
              MulishText(
                text: desc,
                fontColor: CustomColors.customPantone,
                fontSize: 12,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
