import 'package:flutter/material.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.onSaved,
  }) : super(key: key);
  final Function(String) onSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          SplashScreenNotifier.getLanguageLabel('Enter registered email'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5.0),
        TextFormField(
          initialValue: 'new@mail1.com',
          onSaved: (newValue) => onSaved(newValue!),
          validator: (value) => value!.isEmpty ? SplashScreenNotifier.getLanguageLabel('Required') : null,
          cursorColor: Colors.black,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            isDense: true,
            fillColor: Colors.white,
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
