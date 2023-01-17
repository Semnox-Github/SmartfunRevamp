import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/routes.dart';

import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key, required this.info}) : super(key: key);
  final AndroidDeviceInfo? info;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    ref.read(splashScreenProvider.notifier).getBaseUrl();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<SplashScreenState>(
      splashScreenProvider,
      (_, next) {
        next.maybeWhen(
          orElse: () {},
          success: () => Navigator.pushReplacementNamed(context, Routes.kAfterSplashScreenPage),
        );
      },
    );
    return Scaffold(
      body: Image.asset('assets/splash_screen/splash_screen.png'),
    );
  }
}

   // if (Platform.isAndroid && (widget.info?.version.sdkInt ?? 0) > 30) {
    // return EasySplashScreen(
    //   backgroundImage: const AssetImage('assets/splash_screen/splash_screen.png'),
    //   backgroundColor: Colors.white,
    //   navigator: const AfterSplashScreen(),
    //   showLoader: false,
    //   logo: Image.asset('assets/splash_screen/transparent.png'),
    // );
    // }
    // return const AfterSplashScreen();