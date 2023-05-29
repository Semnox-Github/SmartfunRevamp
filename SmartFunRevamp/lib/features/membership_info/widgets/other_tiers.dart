import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/membership_info/pages/membership_info_page.dart';

import '../../../colors/colors.dart';

class OtherTiers extends StatelessWidget {
  const OtherTiers({
    super.key,
    required this.tier,
    required this.title,
    required this.subtitle,
  });

  final MembershipTier tier;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/membership/${tier.name}.png',
          height: 100,
        ),
        MulishText(
          text: title,
          fontWeight: FontWeight.bold,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MulishText(
              text: subtitle,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
            const SizedBox(width: 10.0),
            const MulishText(
              text: 'More >>',
              fontWeight: FontWeight.bold,
              fontColor: CustomColors.hardOrange,
              textDecoration: TextDecoration.underline,
              fontSize: 12.0,
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        if (tier != MembershipTier.platinum)
          const SizedBox(
            height: 50,
            child: DottedLine(
              direction: Axis.vertical,
              dashColor: Colors.black,
            ),
          ),
      ],
    );
  }
}
