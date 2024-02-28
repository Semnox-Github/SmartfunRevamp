import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
//import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/firebase/firebase_api.dart';
import 'package:semnox/firebase_options.dart';
import 'package:semnox/lifecycle_handler.dart';
import 'package:semnox/themes/main_theme.dart';
import 'di/injection_container.dart' as di;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  WidgetsBinding.instance.addObserver(LifecycleEventHandler(
    resumeCallBack: () async {
      final remoteMessageStream = FirebaseMessaging.onMessageOpenedApp;
      final notificationData =
          NotificationsData.fromJson((await remoteMessageStream.first).data);
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
  CachedNetworkImage.logLevel = CacheManagerLogLevel.none;
  di.init();
  //runApp(const MyApp());
  runApp(const ProviderScope(child: MyApp()));
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

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
  // _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // return ProviderScope(
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: _posibleLoadings[Random().nextInt(_posibleLoadings.length)],
        ),
      ),
      child: MaterialApp(
        title: 'SmartFun',
        navigatorKey: navigatorKey,
        routes: Routes.routesMap,
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) => Scaffold(
              appBar: AppBar(),
              body: Center(
                child: MulishText(
                    text:
                        '404 Page not found.\n Route ${settings.name} not found'),
              ),
            ),
          );
        },
        initialRoute: Routes.initialRoute,

        //theme: getAppTheme(context, kMainTheme)
        theme: getAppTheme(context, ref.watch(appThemeProvider)),
        //kMainTheme, //
      ),
    );
    // );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // debugPrint("$state");
    if (state == AppLifecycleState.inactive) {
      // The app is closed, clear the cache
      await DefaultCacheManager().emptyCache();
    }
  }
}
