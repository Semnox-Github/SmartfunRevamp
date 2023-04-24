import 'dart:async';
import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class CountdownText extends StatefulWidget {
  const CountdownText({Key? key, required this.onPressed}) : super(key: key);
  final Function() onPressed;

  @override
  CountdownTextState createState() => CountdownTextState();
}

class CountdownTextState extends State<CountdownText> {
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
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_time == 0) {
      return TextButton(
        onPressed: () {
          setState(() {
            _time = 30;
          });
          startTimer();
          widget.onPressed();
        },
        child: const MulishText(
          text: 'Resend OTP',
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.start,
          fontColor: CustomColors.hardOrange,
        ),
      );
    }
    return MulishText(
      text: 'Resend OTP in $_time seconds',
      fontWeight: FontWeight.bold,
      textAlign: TextAlign.start,
      fontColor: CustomColors.hardOrange,
    );
  }
}
