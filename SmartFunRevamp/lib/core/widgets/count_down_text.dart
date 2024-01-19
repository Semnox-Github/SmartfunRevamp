import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class CountdownText extends ConsumerStatefulWidget {
  const CountdownText({Key? key, required this.onPressed}) : super(key: key);
  final Function() onPressed;

  @override
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => CountdownTextState();
  // CountdownTextState createState() => CountdownTextState();
}

class CountdownTextState extends ConsumerState<CountdownText> {
  int _time = 30;

  late Timer _timer;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_time == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _time--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    final cmsBody = ref.read(cmsBodyStyleProvider);
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cmsBody = ref.watch(cmsBodyStyleProvider);
    if (_time == 0) {
      return TextButton(
        onPressed: () {
          setState(() {
            _time = 30;
          });
          startTimer();
          widget.onPressed();
        },
        child: MulishText(
            text: SplashScreenNotifier.getLanguageLabel('Resend OTP'),
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
            fontColor: HexColor.fromHex(
                cmsBody?.linkTextColor) //CustomColors.hardOrange,
            ),
      );
    }
    return MulishText(
      text: SplashScreenNotifier.getLanguageLabel('Resend OTP in &1 seconds')
          .replaceAll("&1", _time.toString()),
      fontWeight: FontWeight.bold,
      textAlign: TextAlign.start,
      fontColor: CustomColors.hardOrange,
    );
  }
}
