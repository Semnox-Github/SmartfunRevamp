import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/firebase/firebase_api.dart';
import 'package:semnox/firebase_options.dart';
import 'package:semnox/lifecycle_handler.dart';
import 'package:semnox/themes/main_theme.dart';
import 'di/injection_container.dart' as di;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addObserver(LifecycleEventHandler(
    resumeCallBack: () async {
      final remoteMessageStream = FirebaseMessaging.onMessageOpenedApp;
      final notificationData = NotificationsData.fromJson((await remoteMessageStream.first).data);
      Logger().d('TEST -> ${notificationData.toJson()}');
      navigatorKey.currentState?.pushNamed(notificationData.path);
    },
  ));
  await dotenv.load(fileName: ".env");
  if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      name: "SmartFunGiga",
    );
    await FirebaseApi().initNotifications();
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
  di.init();
  runApp(const MyApp());
}

const _posibleLoadings = [
  LoadingIndicator(
    indicatorType: Indicator.ballPulse,
    colors: [CustomColors.hardOrange],
  ),
  LoadingIndicator(
    indicatorType: Indicator.ballPulseSync,
    colors: [CustomColors.hardOrange],
  ),
  LoadingIndicator(
    indicatorType: Indicator.ballRotateChase,
    colors: [CustomColors.hardOrange],
  )
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ProviderScope(
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: SizedBox(
            height: 50.0,
            width: 50.0,
            child: _posibleLoadings[Random().nextInt(_posibleLoadings.length)],
          ),
        ),
        child: MaterialApp(
          title: 'Flutter Demo',
          navigatorKey: navigatorKey,
          routes: Routes.routesMap,
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) => Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: MulishText(text: '404 Page not found.\n Route ${settings.name} not found'),
                ),
              ),
            );
          },
          initialRoute: Routes.initialRoute,
          theme: kMainTheme,
        ),
      ),
    );
  }
}
