import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semnox/colors/inputs_decorations.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class AmountFormField extends StatelessWidget {
  const AmountFormField({
    super.key,
    required this.entitlement,
    required this.onSaved,
  });

  final String entitlement;
  final Function(String?) onSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MulishText(
            text: SplashScreenNotifier.getLanguageLabel('Enter the &1 you want to transfer').replaceAll("&1", entitlement),
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            validator: (value) => value.isNullOrEmpty() ? SplashScreenNotifier.getLanguageLabel('Required') : null,
            onSaved: onSaved,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              enabledBorder: CustomInputDecorations.k12RoundedCustomBlue,
              focusedBorder: CustomInputDecorations.k12RoundedCustomBlue,
              errorBorder: CustomInputDecorations.k12RoundedError,
              focusedErrorBorder: CustomInputDecorations.k12RoundedError,
              hintText: SplashScreenNotifier.getLanguageLabel('Amount'),
            ),
          ),
        ],
      ),
    );
  }
}
