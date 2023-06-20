import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/features/splash/splashscreen.dart';
import 'package:semnox/firebase_options.dart';
import 'di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

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
          routes: Routes.routesMap,
          home: const SplashScreen(),
          theme: ThemeData(
            useMaterial3: true,
            iconTheme: const IconThemeData(color: CustomColors.customBlue),
            inputDecorationTheme: InputDecorationTheme(
              isDense: true,
              fillColor: Colors.transparent,
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
