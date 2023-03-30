import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class MoreContainer extends StatelessWidget {
  const MoreContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
      decoration: const BoxDecoration(
        color: CustomColors.customLigthBlue,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.0),
        ),
      ),
      child: Row(
        children: const [
          MulishText(
            text: 'More',
            fontWeight: FontWeight.bold,
            fontColor: CustomColors.customBlue,
            fontSize: 24,
          ),
        ],
      ),
    );
  }
}
