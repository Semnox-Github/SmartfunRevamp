import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
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
          if (!isLoginWithOTP)
            const Text(
              "Don't worry about password",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 10.0),
          TextButton(
            onPressed: onTap,
            child: Text(
              isLoginWithOTP ? 'LOGIN WITH EMAIL' : 'LOGIN WITH OTP',
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
