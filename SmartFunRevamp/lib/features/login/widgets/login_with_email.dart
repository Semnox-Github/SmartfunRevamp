import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/email_field.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/core/widgets/password_field.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class LoginWithEmail extends ConsumerWidget {
  LoginWithEmail({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cmsBody = ref.watch(cmsBodyStyleProvider);
    String mLogin = '';
    String mPassword = '';
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          EmailTextField(
            onSaved: (loginId) => mLogin = loginId,
          ),
          const SizedBox(height: 20.0),
          PasswordField(
            onSaved: (password) => mPassword = password,
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: MulishText(
                  text:
                      SplashScreenNotifier.getLanguageLabel('Forgot Password?'),
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.kForgotPassword),
                child: MulishText(
                    text: SplashScreenNotifier.getLanguageLabel('RESET NOW'),
                    fontWeight: FontWeight.bold,
                    fontColor: HexColor.fromHex(
                        cmsBody?.linkTextColor) //CustomColors.hardOrange,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          CustomButton(
            label: SplashScreenNotifier.getLanguageLabel('LOGIN'),
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                ref.read(loginProvider.notifier).loginUser(mLogin, mPassword);
              }
            },
          ),
        ],
      ),
    );
  }
}
