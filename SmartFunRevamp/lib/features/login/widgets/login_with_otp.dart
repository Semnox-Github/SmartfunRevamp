import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/sign_up/pages/sign_up_page.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class LoginWithOTP extends ConsumerWidget {
  LoginWithOTP({
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String phone = '';
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            onSaved: (value) => phone = value,
            label: SplashScreenNotifier.getLanguageLabel('Enter registered phone number'),
            inputType: TextInputType.phone,
            fillColor: Colors.white,
            initialValue: '988789987',
          ),
          const SizedBox(height: 20.0),
          CustomButton(
            label: SplashScreenNotifier.getLanguageLabel('SEND OTP'),
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                ref.read(loginProvider.notifier).loginUserWithOTP(phone);
              }
            },
          ),
        ],
      ),
    );
  }
}
