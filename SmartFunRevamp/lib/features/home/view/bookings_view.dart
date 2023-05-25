import 'package:flutter/material.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        SplashScreenNotifier.getLanguageLabel('Bookings'),
      ),
    );
  }
}
