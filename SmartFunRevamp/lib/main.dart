import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/features/buy_a_card/pages/buy_card_list_page.dart';
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
          routes: Routes.routesMap,
          // home: SplashScreen(info: _androidDeviceInfo),
          home: const BuyCardListPage(),
          theme: ThemeData(
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
