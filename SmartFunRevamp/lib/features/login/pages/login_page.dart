import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/routes.dart';

import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/login/widgets/login_container.dart';
import 'package:semnox/features/login/widgets/login_with_otp_container.dart';
import 'package:semnox/features/login/widgets/social_logins_container.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool isOTPLogin = false;
  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(loginProvider, (_, next) {
      next.maybeWhen(
        inProgress: () => context.loaderOverlay.show(),
        orElse: () => context.loaderOverlay.hide(),
        success: () {
          context.loaderOverlay.hide();
          Navigator.pushReplacementNamed(context, Routes.kHomePage);
        },
        selectLocationNeeded: () {
          context.loaderOverlay.hide();
          Navigator.pushReplacementNamed(context, Routes.kEnableLocation);
        },
        otpGenerated: () {
          context.loaderOverlay.hide();
          Navigator.pushNamed(context, Routes.kVerifyOTP);
        },
        error: (message) {
          context.loaderOverlay.hide();
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            title: SplashScreenNotifier.getLanguageLabel('Error'),
            desc: message,
            btnCancelOnPress: () {},
            useRootNavigator: true,
            btnOkOnPress: () {},
          ).show();
        },
      );
    });
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              LoginContainer(
                isOTPLogin: isOTPLogin,
              ),
              const SizedBox(height: 20.0),
              LoginWithOTPContainer(
                isLoginWithOTP: isOTPLogin,
                onTap: () {
                  setState(() {
                    isOTPLogin = !isOTPLogin;
                  });
                },
              ),
              const SizedBox(height: 10.0),
              const SocialLoginsContainer(),
              const SizedBox(height: 40.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    SplashScreenNotifier.getLanguageLabel('New to SmartFun?'),
                    style: GoogleFonts.mulish(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, Routes.kSignUpPage),
                    child: Text(
                      SplashScreenNotifier.getLanguageLabel('SIGN UP'),
                      style: GoogleFonts.mulish(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.hardOrange,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
