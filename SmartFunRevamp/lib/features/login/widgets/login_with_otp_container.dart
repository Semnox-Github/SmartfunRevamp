import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class LoginWithOTPContainer extends StatelessWidget {
  const LoginWithOTPContainer({
    Key? key,
    required this.onTap,
    required this.isLoginWithOTP,
  }) : super(key: key);
  final Function() onTap;
  final bool isLoginWithOTP;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: CustomColors.customLigthGray,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isLoginWithOTP)
            const MulishText(
              text: "Don't worry about password",
              fontWeight: FontWeight.bold,
            ),
          const SizedBox(height: 10.0),
          TextButton(
            onPressed: onTap,
            child: Text(
              isLoginWithOTP ? SplashScreenNotifier.getLanguageLabel('LOGIN WITH OTP') : SplashScreenNotifier.getLanguageLabel('LOGIN WITH PASSWORD'),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: CustomColors.hardOrange,
              ),
            ),
          )
        ],
      ),
    );
  }
}
