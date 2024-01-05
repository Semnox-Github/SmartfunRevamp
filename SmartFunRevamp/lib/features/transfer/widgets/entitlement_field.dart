import 'package:flutter/material.dart';
import 'package:semnox/core/widgets/custom_native_dropdown.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class EntitlementField extends StatelessWidget {
  const EntitlementField({super.key, required this.onChanged});
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        MulishText(
          text: SplashScreenNotifier.getLanguageLabel('Select Entitlement'),
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 10.0),
        CustomNativeDropdown(
          items: const ['Credits', 'Bonus', 'Tickets' , 'Play Credits'],
          onChanged: onChanged,
        ),
      ],
    );
  }
}
