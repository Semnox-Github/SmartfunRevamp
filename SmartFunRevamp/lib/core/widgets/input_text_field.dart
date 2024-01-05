import 'package:flutter/material.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.onSaved,
    required this.hintText,
    required this.prefixIcon,
    this.initialValue,
  }) : super(key: key);

  final Function(String) onSaved;
  final String hintText;
  final Widget prefixIcon;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: initialValue,
          onSaved: (newValue) => onSaved(newValue!),
          validator: (value) => value?.isEmpty ?? false ? SplashScreenNotifier.getLanguageLabel('Required') : null,
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            isDense: true,
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            prefixIcon: prefixIcon,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        )
      ],
    );
  }
}
