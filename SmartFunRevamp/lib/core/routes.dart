import 'package:flutter/material.dart';
import 'package:semnox/features/account/account_page.dart';
import 'package:semnox/features/activity/card_activity_log_page.dart';
import 'package:semnox/features/buy_a_card/pages/buy_card_list_page.dart';
import 'package:semnox/features/gameplays/pages/gameplays_page.dart';
import 'package:semnox/features/home/pages/home_page.dart';
import 'package:semnox/features/home/view/delete_profile_otp_page.dart';
import 'package:semnox/features/login/pages/login_page.dart';
import 'package:semnox/features/login/pages/verify_otp_page.dart';
import 'package:semnox/features/membership_info/pages/membership_info_page.dart';
import 'package:semnox/features/notifications/pages/notification_center_page.dart';
import 'package:semnox/features/notifications/pages/notifications_settings_page.dart';
import 'package:semnox/features/recharge_card/pages/select_recharge_card_page.dart';
import 'package:semnox/features/reset_password/pages/forgot_password_page.dart';
import 'package:semnox/features/reset_password/pages/reset_password_page.dart';
import 'package:semnox/features/search/pages/search_page.dart';
import 'package:semnox/features/select_location/pages/enable_location_page.dart';
import 'package:semnox/features/select_location/pages/map_page.dart';
import 'package:semnox/features/select_location/pages/select_location_manually_page.dart';
import 'package:semnox/features/sign_up/pages/sign_up_page.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';
import 'package:semnox/features/transfer/transfer_page.dart';

import '../features/lost_card/pages/select_lost_card_page.dart';

class Routes {
  static const kHomePage = '/home';
  static const kLogInPage = '/log_in';
  static const kSplashScreenPage = '/splash_screen';
  static const kAfterSplashScreenPage = '/after_splash_screen';
  static const kSignUpPage = '/sign_up';
  static const kBuyACard = '/buy_a_card';
  static const kVerifyOTP = '/verify_otp';
  static const kDeleteOTP = '/delete_otp';
  static const kSelectLocationManually = '/select_location_manually';
  static const kMap = '/map';
  static const kEnableLocation = '/enable_location';
  static const kRechargePageCard = '/recharge_card';
  static const kLostPageCard = '/lost_card';
  static const kGameplays = '/gameplays';
  static const kActivities = '/activities';
  static const kTransfers = '/transfers';
  static const kNotifications = '/notifications';
  static const kNotificationsSettings = '/notifications_settings';
  static const kAccount = '/account';
  static const kForgotPassword = '/forgot_password';
  static const kResetPassword = '/reset_password';
  static const kMembershipInfo = '/membership_info';
  static const kSearch = '/search';

  static String get initialRoute => kSplashScreenPage;

  static Map<String, WidgetBuilder> get routesMap {
    return {
      kHomePage: (BuildContext context) => const HomePage(),
      kLogInPage: (BuildContext context) => const LoginPage(),
      kSignUpPage: (BuildContext context) => SignUpPage(),
      kAfterSplashScreenPage: (BuildContext context) => const AfterSplashScreen(),
      kBuyACard: (BuildContext context) => const BuyCardListPage(),
      kVerifyOTP: (BuildContext context) => const VerifyOtpPage(),
      kDeleteOTP: (BuildContext context) => const DeleteProfileOTPPage(),
      kSelectLocationManually: (BuildContext context) => const SelectLocationManuallyPage(),
      kEnableLocation: (BuildContext context) => const EnableLocationPage(),
      kMap: (BuildContext context) => const MapPage(),
      kRechargePageCard: (BuildContext context) => const SelectCardRechargePage(),
      kGameplays: (BuildContext context) => const GameplaysPage(),
      kActivities: (BuildContext context) => const CardActivityLogPage(),
      kTransfers: (BuildContext context) => const TransferPage(),
      kLostPageCard: (BuildContext context) => const SelectCardLostPage(),
      kNotifications: (BuildContext context) => const NotificationCenterPage(),
      kNotificationsSettings: (BuildContext context) => const NotificationsSettingsPage(),
      kAccount: (BuildContext context) => AccountPage(),
      kForgotPassword: (BuildContext context) => ForgotPasswordPage(),
      kResetPassword: (BuildContext context) => const ResetPasswordPage(),
      kMembershipInfo: (BuildContext context) => const MembershipInfoPage(),
      kSearch: (BuildContext context) => const SearchPage(),
    };
  }
}
