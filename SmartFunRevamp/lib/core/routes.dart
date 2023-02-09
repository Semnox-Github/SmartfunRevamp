import 'package:flutter/material.dart';
import 'package:semnox/features/buy_a_card/pages/buy_card_list_page.dart';
import 'package:semnox/features/home/pages/home_page.dart';
import 'package:semnox/features/login/pages/login_page.dart';
import 'package:semnox/features/login/pages/verify_otp_page.dart';
import 'package:semnox/features/recharge_card/select_recharge_card.dart';
import 'package:semnox/features/select_location/pages/enable_location_page.dart';
import 'package:semnox/features/select_location/pages/map_page.dart';
import 'package:semnox/features/select_location/pages/select_location_manually_page.dart';
import 'package:semnox/features/sign_up/pages/sign_up_page.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';

class Routes {
  static const kHomePage = '/home';
  static const kLogInPage = '/log_in';
  static const kSplashScreenPage = '/splash_screen';
  static const kAfterSplashScreenPage = '/after_splash_screen';
  static const kSignUpPage = '/sign_up';
  static const kBuyACard = '/buy_a_card';
  static const kVerifyOTP = '/verify_otp';
  static const kSelectLocationManually = '/select_location_manually';
  static const kMap = '/map';
  static const kEnableLocation = '/enable_location';
  static const kRechargePageCard = '/recharge_card';

  static String get initialRoute => kSplashScreenPage;

  static Map<String, WidgetBuilder> get routesMap {
    return {
      kHomePage: (BuildContext context) => const HomePage(),
      kLogInPage: (BuildContext context) => const LoginPage(),
      kSignUpPage: (BuildContext context) => SignUpPage(),
      kAfterSplashScreenPage: (BuildContext context) => const AfterSplashScreen(),
      kBuyACard: (BuildContext context) => const BuyCardListPage(),
      kVerifyOTP: (BuildContext context) => const VerifyOtpPage(),
      kSelectLocationManually: (BuildContext context) => const SelectLocationManuallyPage(),
      kEnableLocation: (BuildContext context) => const EnableLocationPage(),
      kMap: (BuildContext context) => const MapPage(),
      kRechargePageCard: (BuildContext context) => const SelectCardRecharge()
    };
  }
}
