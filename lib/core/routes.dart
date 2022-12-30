import 'package:flutter/material.dart';
import 'package:semnox/features/home/pages/home_page.dart';
import 'package:semnox/features/login/pages/login_page.dart';
import 'package:semnox/features/sign_up/pages/sign_up_page.dart';

class Routes {
  static const kHomePage = '/home';
  static const kLogInPage = '/log_in';
  static const kSplashScreenPage = '/splash_screen';
  static const kSignUpPage = '/sign_up';

  static String get initialRoute => kSplashScreenPage;

  static Map<String, WidgetBuilder> get routesMap {
    return {
      kHomePage: (BuildContext context) => const HomePage(),
      kLogInPage: (BuildContext context) => LoginPage(),
      kSignUpPage: (BuildContext context) => SignUpPage(),
    };
  }
}
