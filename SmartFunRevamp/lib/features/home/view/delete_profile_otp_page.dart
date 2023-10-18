import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
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
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class DeleteProfileOTPPage extends ConsumerStatefulWidget {
  const DeleteProfileOTPPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeleteProfileOTPPageState();
}

class _DeleteProfileOTPPageState extends ConsumerState<DeleteProfileOTPPage> {
  late String otp;
  @override
  void initState() {
    super.initState();
    otp = "";
  }

  @override
  Widget build(BuildContext context) {
    final user = Get.find<CustomerDTO>();
    String phoneNumber = user.phone == null || user.phone == "" ? user.email! : user.phone!;
    ref.listen<LoginState>(loginProvider, (_, next) {
      next.maybeWhen(
        inProgress: () => context.loaderOverlay.show(),
        orElse: () => context.loaderOverlay.hide(),
        otpVerified: () {
          context.loaderOverlay.hide();
          ref.read(loginProvider.notifier).deleteProfile();
          Dialogs.deleteProfileSuccessDialog(
            context,
            () {
              Navigator.popAndPushNamed(context, Routes.kLogInPage);
            },
          );
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
                phoneNumber.contains('@')
                    ? SplashScreenNotifier.getLanguageLabel('We have mailed you an OTP')
                    : SplashScreenNotifier.getLanguageLabel('We have sent an OTP to your mobile number'),
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
                  fieldHeight: MediaQuery.of(context).size.width * 0.12,
                  fieldWidth: MediaQuery.of(context).size.width * 0.12,
                ),
              ),
              MulishText(
                text: SplashScreenNotifier.getLanguageLabel("Didn't receive the OTP?"),
                textAlign: TextAlign.start,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10.0),
              CountdownText(
                onPressed: () => ref.read(loginProvider.notifier).resendDeleteOtp(phoneNumber),
              ),
              const SizedBox(height: 100.0),
              CustomButton(
                onTap: () {
                  if (otp.isEmpty) {
                    Fluttertoast.showToast(msg: SplashScreenNotifier.getLanguageLabel('Please enter the OTP'));
                  } else {
                    try {
                      ref.read(loginProvider.notifier).verifyDeleteOTP(otp);
                    } catch (e) {
                      null;
                    }
                  }
                },
                label: SplashScreenNotifier.getLanguageLabel('VERIFY & PROCEED'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
