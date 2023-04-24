import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/use_cases/authentication/send_otp_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/verify_otp_use_case.dart';
import 'package:semnox/core/enums/contact_enum.dart';

part 'verify_state.dart';
part 'verify_provider.freezed.dart';

final sendOtpStateProvider = StateNotifierProvider<SendOtpStateProvider, SendOtpState>(
  (ref) => SendOtpStateProvider(
    Get.find<SendOTPUseCase>(),
    Get.find<VerifyOTPUseCase>(),
  ),
);

class SendOtpStateProvider extends StateNotifier<SendOtpState> {
  SendOtpStateProvider(this._sendOTPUseCase, this._verifyOTPUseCase) : super(const _Initial());
  final SendOTPUseCase _sendOTPUseCase;
  final VerifyOTPUseCase _verifyOTPUseCase;
  String otpId = '';
  void sendOTP(String phoneOrEmail, ContactType contactType) async {
    state = const _InProgress();
    final response = await _sendOTPUseCase({contactType == ContactType.email ? 'EmailId' : 'Phone': phoneOrEmail, 'Source': 'LOGIN_OTP_EVENT'});
    state = response.fold(
      (l) => _Error(l.message),
      (r) {
        otpId = r;
        return _Success(contactType);
      },
    );
  }

  void verifyOTP(String otp, ContactType contactType) async {
    state = const _InProgress();
    final response = await _verifyOTPUseCase({'code': otp}, otpId);
    state = response.fold(
      (l) {
        Logger().e(l.message);
        return _Error(l.message);
      },
      (r) {
        return _OTPVerified(contactType);
      },
    );
  }
}
