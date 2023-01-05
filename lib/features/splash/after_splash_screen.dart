import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/routes.dart';

class AfterSplashScreen extends StatelessWidget {
  const AfterSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset('assets/splash_screen/after_splash.png'),
            const SizedBox(height: 10.0),
            const Text(
              'QUICK CARD RECHARGES',
              style: TextStyle(
                color: CustomColors.customBlack,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(
                color: CustomColors.customBlack,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Preferred Language to be used in the app',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.mulish(
                      color: CustomColors.customBlack,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  DropdownButton<String>(
                    value: 'English',
                    isExpanded: true,
                    items: ['English', 'Spanish'].map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  )
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Have an account?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(
                          color: CustomColors.customBlack,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          gradient: CustomGradients.linearGradient,
                        ),
                        margin: const EdgeInsets.all(3),
                        child: TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(context, Routes.kLogInPage),
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
                const SizedBox(width: 5.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New to SmartFun?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(
                          color: CustomColors.customBlack,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: CustomGradients.linearGradient,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.all(3),
                          child: TextButton(
                            onPressed: () => Navigator.pushReplacementNamed(context, Routes.kSignUpPage),
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: CustomColors.hardOrange,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
