import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/sign_up/pages/sign_up_page.dart';

class LoginWithOTP extends ConsumerWidget {
  LoginWithOTP({
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            onSaved: (phoneOrEmail) => {},
            label: 'Enter registered phone number',
            inputType: TextInputType.emailAddress,
            fillColor: Colors.white,
          ),
          const SizedBox(height: 20.0),
          CustomButton(
            label: 'SEND OTP',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                ref.read(loginProvider.notifier).loginUserWithOTP('');
              }
            },
          ),
        ],
      ),
    );
  }
}
