import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';

String censorPhoneNumber(String phoneNumber) {
  return phoneNumber.replaceRange(0, phoneNumber.length - 3, 'X' * (phoneNumber.length - 3));
}

class VerifyOtpPage extends ConsumerWidget {
  const VerifyOtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String phoneNumber = censorPhoneNumber(ref.read(loginProvider.notifier).phone);
    String otp = '';
    ref.listen<LoginState>(loginProvider, (_, next) {
      next.maybeWhen(
        inProgress: () => context.loaderOverlay.show(),
        orElse: () => context.loaderOverlay.hide(),
        otpVerified: () {
          context.loaderOverlay.hide();
          Navigator.pushNamedAndRemoveUntil(context, Routes.kHomePage, (route) => false);
        },
        otpVerificationError: (message) {
          context.loaderOverlay.hide();
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            title: 'Error',
            desc: message,
            btnCancelOnPress: () {},
            useRootNavigator: true,
            btnOkOnPress: () {},
          ).show();
        },
      );
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.customLigthBlue,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColors.customBlue,
          ),
        ),
        title: Text(
          'OTP Verification',
          style: GoogleFonts.mulish(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: CustomColors.customBlue,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We have sent an OTP to your mobile number $phoneNumber.\nEnter the OTP to verify.',
                style: GoogleFonts.mulish(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 40.0),
              OtpTextField(
                numberOfFields: 6,
                showFieldAsBox: true,
                focusedBorderColor: CustomColors.hardOrange,
                onCodeChanged: (String code) => otp = code,
                onSubmit: (String verificationCode) => ref.read(loginProvider.notifier).verifyOTP(verificationCode),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 40.0),
              InkWell(
                onTap: () {},
                child: const Text(
                  "Didn't receive OTP?",
                  style: TextStyle(color: CustomColors.hardOrange),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Resend OTP in 30 seconds',
                style: GoogleFonts.mulish(
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 100.0),
              CustomButton(
                onTap: () {
                  if (otp.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please enter the OTP');
                  }
                  ref.read(loginProvider.notifier).verifyOTP(otp);
                },
                label: 'Verify & Procced',
              )
            ],
          ),
        ),
      ),
    );
  }
}
