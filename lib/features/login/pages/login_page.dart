import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/widgets/custom_button.dart';

import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/sign_up/pages/sign_up_page.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<LoginState>(loginProvider, (_, next) {
      next.maybeWhen(
        inProgress: () => context.loaderOverlay.show(),
        orElse: () => context.loaderOverlay.hide(),
        success: () {
          context.loaderOverlay.hide();
          Navigator.pushReplacementNamed(context, Routes.kHomePage);
        },
        error: (message) {
          context.loaderOverlay.hide();
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            title: 'Error',
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
              Stack(
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
                      color: CustomColors.customLigthBlue,
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ),
                    ),
                    // child: LoginWithEmail(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            onSaved: (phoneOrEmail) => {},
                            label: 'Enter registered phone number or email',
                            inputType: TextInputType.emailAddress,
                            fillColor: Colors.white,
                          ),
                          const SizedBox(height: 20.0),
                          CustomButton(
                            label: 'SEND OTP',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                ref.read(loginProvider.notifier).loginUserWithOTP('');
                              }
                            },
                          ),
                        ],
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
              ),
              const SizedBox(height: 20.0),
              Container(
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
                  children: const [
                    Text(
                      "Don't worry about password",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'LOGIN WITH OTP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.hardOrange,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
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
                    const Text(
                      'Or Continue with social Logins',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
              ),
              const SizedBox(height: 40.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New to SmartFun?',
                    style: GoogleFonts.mulish(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, Routes.kSignUpPage),
                    child: Text(
                      'SIGN UP',
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
