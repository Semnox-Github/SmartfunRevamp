import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:semnox/main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key, required this.info}) : super(key: key);
  final AndroidDeviceInfo? info;
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid && (info?.version.sdkInt ?? 0) > 30) {
      return EasySplashScreen(
        backgroundImage: const AssetImage('assets/splash_screen/splash_screen.png'),
        backgroundColor: Colors.white,
        navigator: const MyHomePage(title: ""),
        durationInSeconds: 3,
        showLoader: false,
        logo: Image.asset('assets/splash_screen/transparent.png'),
      );
    }
    return const MyHomePage(title: 'Flutter Demo Home Page');
  }
}
