import 'package:flutter/material.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class BottomSheetButton extends StatelessWidget {
  BottomSheetButton({
    super.key,
    required this.onTap,
    required this.backgroundColor,
  });
  final Function() onTap;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.0),
      color: backgroundColor,
      child: CustomButton(
        onTap: onTap,
        label: SplashScreenNotifier.getLanguageLabel('TRANSFER CREDITS'),
      ),
    );
  }
}
