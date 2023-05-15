import 'package:flutter/material.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({
    super.key,
    required this.onTap,
  });
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      color: Colors.white,
      child: CustomButton(
        onTap: onTap,
        label: SplashScreenNotifier.getLanguageLabel('TRANSFER CREDITS'),
      ),
    );
  }
}
