import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/reset_password/provider/reset_password_provider.dart';
import 'package:semnox/features/sign_up/pages/sign_up_page.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class ForgotPasswordPage extends ConsumerWidget {
  ForgotPasswordPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(resetPasswordStateProvider, (_, next) {
      next.maybeWhen(
        orElse: () => Logger().d('orElse'),
        error: (message) {
          context.loaderOverlay.hide();
          Dialogs.showErrorMessage(context, message);
        },
        inProgress: () => context.loaderOverlay.show(),
        success: () {
          context.loaderOverlay.hide();
          Navigator.popAndPushNamed(context, Routes.kResetPassword);
        },
      );
    });
    return Scaffold(
      appBar: CustomAppBar(title: SplashScreenNotifier.getLanguageLabel('Forgot Password')),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const MulishText(
                text: 'Enter your registered email or mobile below to receive password reset instructions.',
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                onSaved: (emailOrPhone) {
                  ref.read(resetPasswordStateProvider.notifier).sendEmail(emailOrPhone);
                },
                label: SplashScreenNotifier.getLanguageLabel('Enter registered phone number or email'),
              ),
              const Spacer(),
              CustomButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
                label: SplashScreenNotifier.getLanguageLabel('SEND'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
