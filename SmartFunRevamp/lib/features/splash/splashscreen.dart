import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/routes.dart';

import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
          success: () => Navigator.pushReplacementNamed(context, Routes.kEnableLocation),
        );
      },
    );
    return Scaffold(
      body: Image.asset(
        'assets/splash_screen/splash_screen.png',
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
