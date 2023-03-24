import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/cards_detail/bonus_summary_page.dart';

class NotificationsSettingsPage extends StatelessWidget {
  const NotificationsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: MulishText(
          text: 'Notifications Preferences',
          fontWeight: FontWeight.bold,
          fontColor: CustomColors.customBlue,
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            NotificationSetting(
              title: 'Promotional Notifications',
              description: 'Receive push notifications about new offers and deals on your mobile phone',
              onChanged: (_) {},
            ),
            NotificationSetting(
              title: 'Transactional Notifications',
              description: 'Receive push notifications about new transactions made.',
              onChanged: (_) {},
            ),
            NotificationSetting(
              title: 'Email Notifications',
              description: 'Receive emails about new offers and deals',
              onChanged: (_) {},
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
                        widget.description,
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
