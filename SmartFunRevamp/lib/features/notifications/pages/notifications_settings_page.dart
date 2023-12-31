import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class NotificationsSettingsPage extends StatelessWidget {
  const NotificationsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: SplashScreenNotifier.getLanguageLabel('Notifications Preferences'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            NotificationSetting(
              title: SplashScreenNotifier.getLanguageLabel('Promotional Notifications'),
              description: SplashScreenNotifier.getLanguageLabel('Receive push notifications about new offers and deals on your mobile phone'),
              onChanged: (_) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: MulishText(
                      text: 'Not implemented yet',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
            NotificationSetting(
              title: SplashScreenNotifier.getLanguageLabel('Transactional Notifications'),
              description: SplashScreenNotifier.getLanguageLabel('Receive push notifications about new transactions made.'),
              onChanged: (_) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: MulishText(
                      text: 'Not implemented yet',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
            NotificationSetting(
              title: SplashScreenNotifier.getLanguageLabel('Email Notifications'),
              description: SplashScreenNotifier.getLanguageLabel('Receive emails about new offers and deals'),
              onChanged: (_) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: MulishText(
                      text: 'Not implemented yet',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({
    super.key,
    required this.title,
    required this.description,
    required this.onChanged,
  });
  final String title;
  final String description;
  final Function(bool) onChanged;

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool isOn = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MulishText(
                        text: widget.title,
                        fontWeight: FontWeight.bold,
                        fontColor: Colors.black,
                      ),
                      Text(
                        SplashScreenNotifier.getLanguageLabel(widget.description),
                        style: GoogleFonts.mulish(
                          color: CustomColors.couponTextColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                CupertinoSwitch(
                  value: isOn,
                  onChanged: (value) {
                    setState(() {
                      isOn = value;
                    });
                    widget.onChanged(value);
                  },
                  activeColor: CustomColors.hardOrange,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              child: const Divider(
                thickness: 1.5,
                color: CustomColors.customLigthGray,
              ),
            )
          ],
        )
      ],
    );
  }
}
