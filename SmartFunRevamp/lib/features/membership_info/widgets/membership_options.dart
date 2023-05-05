import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class MembershipOptions extends StatelessWidget {
  const MembershipOptions({
    Key? key,
    required this.title,
    required this.svgImage,
    required this.color,
    this.onTap,
  }) : super(key: key);
  final String title;

  final String svgImage;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: CustomColors.customLigthBlue,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50.0,
              width: 50.0,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: color,
              ),
              padding: const EdgeInsets.all(13.0),
              child: SvgPicture.asset(svgImage),
            ),
            MulishText(
              text: title,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
