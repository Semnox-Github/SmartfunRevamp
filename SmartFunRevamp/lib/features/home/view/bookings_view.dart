import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/home/widgets/custom_bottom_bar.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

import '../../splash/provider/new_splash_screen/new_splash_screen_notifier.dart';

class BookingsView extends ConsumerWidget {
  const BookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cmsBody = ref.watch(cmsBodyStyleProvider);

    return Scaffold(
      backgroundColor: HexColor.fromHex(cmsBody?.appBackGroundColor),
      bottomNavigationBar: const CustomBottomBar(),
      body: SafeArea(
        child: Center(
          child: Text(
            SplashScreenNotifier.getLanguageLabel('Bookings'),
          ),
        ),
      ),
    );
  }
}
