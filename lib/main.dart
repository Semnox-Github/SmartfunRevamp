import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/features/splash/splashscreen.dart';
import 'di/injection_container.dart' as di;
import 'dart:io' show Platform;

AndroidDeviceInfo? _androidDeviceInfo;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    _androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
  }
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: ProviderScope(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(info: _androidDeviceInfo),
        ),
      ),
    );
  }
}
