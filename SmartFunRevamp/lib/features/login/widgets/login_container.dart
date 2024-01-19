import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/login/widgets/login_with_email.dart';
import 'package:semnox/features/login/widgets/login_with_otp.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({
    Key? key,
    this.isOTPLogin = false,
  }) : super(key: key);
  final bool isOTPLogin;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, __) {
        final cmsBody = ref.watch(cmsBodyStyleProvider);
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
                top: 70.0,
              ),
              margin: const EdgeInsets.only(top: 50.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: HexColor.fromHex(cmsBody
                    ?.widgetBackgroundColor), //CustomColors.customLigthBlue,
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                child: isOTPLogin
                    ? LoginWithEmail(key: UniqueKey())
                    : LoginWithOTP(
                        key: UniqueKey(),
                      ),
              ),
            ),
            Positioned(
              top: 0,
              child: SvgPicture.asset(
                'assets/login/smart_fun_logo.svg',
              ),
            ),
          ],
        );
      },
    );
  }
}
