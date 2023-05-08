import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/count_down_text.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

String censorPhoneNumber(String phoneNumber) {
  return phoneNumber.replaceRange(0, phoneNumber.length - 3, 'X' * (phoneNumber.length - 3));
}

class DeleteProfileOTPPage extends ConsumerWidget {
  const DeleteProfileOTPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    String phoneNumber = censorPhoneNumber(ref.read(loginProvider.notifier).phone);
    String otp = '';
    ref.read(loginProvider.notifier).resendDeleteOtp();
    ref.listen<LoginState>(loginProvider, (_, next) {
      next.maybeWhen(
        inProgress: () => context.loaderOverlay.show(),
        orElse: () => context.loaderOverlay.hide(),
        otpVerified: () {
          context.loaderOverlay.hide();
          Navigator.popAndPushNamed(context, Routes.kLogInPage);
        },
        otpVerificationError: (message) {
          context.loaderOverlay.hide();
          Dialogs.showErrorMessage(context, message);
        },
      );
    });
    
    return Scaffold(
      appBar: CustomAppBar(title: SplashScreenNotifier.getLanguageLabel('OTP Verification')),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SplashScreenNotifier.getLanguageLabel('We have sent an OTP to your mobile number &1.\nPlease enter the OTP to delete the customer profile.').replaceAll('&1', phoneNumber),
                style: GoogleFonts.mulish(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40.0),
                child: OtpPinField(
                  onSubmit: (otp) => {},
                  onChange: (code) => otp = code,
                  keyboardType: TextInputType.number,
                  otpPinFieldDecoration: OtpPinFieldDecoration.defaultPinBoxDecoration,
                  otpPinFieldStyle: const OtpPinFieldStyle(
                    defaultFieldBorderColor: CustomColors.customOrange,
                    activeFieldBorderColor: CustomColors.hardOrange,
                  ),
                  maxLength: 6,
                ),
              ),
              const MulishText(
                text: "Didn't receive OTP?",
                textAlign: TextAlign.start,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10.0),
              CountdownText(
                onPressed: () => ref.read(loginProvider.notifier).resendDeleteOtp(),
              ),
              const SizedBox(height: 100.0),
              CustomButton(
                onTap: () {
                  if (otp.isEmpty) {
                    Fluttertoast.showToast(msg: SplashScreenNotifier.getLanguageLabel('Please enter the OTP'));
                  } else {
                    try {
                      ref.read(loginProvider.notifier).verifyDeleteOTP(otp);
                      // Navigator.popAndPushNamed(context, Routes.kLogInPage);
                    }
                    catch(e){
                      null;
                    }
                  }
                },
                label: SplashScreenNotifier.getLanguageLabel('Verify & Procced'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
