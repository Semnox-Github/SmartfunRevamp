import 'package:flutter/material.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Reset Password'),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/login/reset_password_success.png',
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  const MulishText(
                    text: 'Reset Password link is sent to your registered email.',
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onTap: () => Navigator.pop(context),
                label: SplashScreenNotifier.getLanguageLabel('DONE'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
