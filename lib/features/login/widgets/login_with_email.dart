import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/email_field.dart';
import 'package:semnox/core/widgets/password_field.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';

class LoginWithEmail extends ConsumerWidget {
  LoginWithEmail({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String mLogin = '';
    String mPassword = '';
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          EmailTextField(
            onSaved: (loginId) => mLogin = loginId,
          ),
          const SizedBox(height: 20.0),
          PasswordField(
            onSaved: (password) => mPassword = password,
          ),
          const SizedBox(height: 20.0),
          RichText(
            text: const TextSpan(
              style: TextStyle(color: CustomColors.customBlue),
              children: [
                TextSpan(
                  text: 'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                WidgetSpan(
                  child: SizedBox(
                    width: 5.0,
                  ),
                ),
                TextSpan(
                  text: 'RESET NOW',
                  style: TextStyle(
                    color: CustomColors.hardOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          CustomButton(
            label: 'LOGIN',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                ref.read(loginProvider.notifier).loginUser(mLogin, mPassword);
              }
            },
          ),
        ],
      ),
    );
  }
}
