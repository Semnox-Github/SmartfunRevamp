import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/features/login/presentation/provider/login_notifier.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<LoginState>(loginProvider, (_, next) {
      next.maybeWhen(
        inProgress: () => context.loaderOverlay.show(),
        orElse: () => context.loaderOverlay.hide(),
        success: () => context.loaderOverlay.hide(),
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
            btnOkOnPress: () {},
          ).show();
        },
      );
    });
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
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
                  decoration: BoxDecoration(
                    color: CustomColors.customLigthBlue,
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const EmailTextField(),
                      const SizedBox(height: 20.0),
                      const PasswordField(),
                      const SizedBox(height: 20.0),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(color: CustomColors.customBlue),
                          children: [
                            TextSpan(
                              text: 'Forgot Password?',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            WidgetSpan(
                              child: SizedBox(
                                width: 5.0,
                              ),
                            ),
                            TextSpan(
                              text: 'RESET NOW',
                              style: TextStyle(
                                color: CustomColors.hardOrange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          gradient: CustomGradients.linearGradient,
                        ),
                        margin: const EdgeInsets.all(3),
                        child: TextButton(
                          onPressed: () => ref.read(loginProvider.notifier).loginUser('admin', 'root1234'),
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                const SizedBox(width: 5.0),
                Text(
                  'SIGN UP',
                  style: GoogleFonts.mulish(
                    fontWeight: FontWeight.bold,
                    color: CustomColors.hardOrange,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5.0),
        TextField(
          obscureText: _isObscured,
          cursorColor: Colors.black,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            isDense: true,
            fillColor: Colors.white,
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
              icon: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
                color: Colors.black,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enter registered phone number or email',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5.0),
        TextField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            isDense: true,
            fillColor: Colors.white,
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
