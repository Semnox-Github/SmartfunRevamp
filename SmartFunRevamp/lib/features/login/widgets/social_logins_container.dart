import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class SocialLoginsContainer extends StatelessWidget {
  const SocialLoginsContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: CustomColors.customLigthGray,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MulishText(
            text: 'Or Continue with social Logins',
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                'assets/login/google.svg',
              ),
              SvgPicture.asset(
                'assets/login/apple.svg',
              ),
              SvgPicture.asset(
                'assets/login/facebook.svg',
              ),
            ],
          )
        ],
      ),
    );
  }
}
