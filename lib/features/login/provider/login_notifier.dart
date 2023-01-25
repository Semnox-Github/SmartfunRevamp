import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_user_by_phone_or_email_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/login_user_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/send_otp_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/verify_otp_use_case.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:semnox/di/injection_container.dart';

part 'login_state.dart';
part 'login_notifier.freezed.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(
    Get.find<SendOTPUseCase>(),
    Get.find<VerifyOTPUseCase>(),
    Get.find<GetUserByPhoneOrEmailUseCase>(),
    Get.find<LoginUserUseCase>(),
  ),
);

class LoginNotifier extends StateNotifier<LoginState> {
  final SendOTPUseCase _sendOTPUseCase;
  final VerifyOTPUseCase _verifyOTPUseCase;
  final GetUserByPhoneOrEmailUseCase _byPhoneOrEmailUseCase;
  final LoginUserUseCase _loginUserUseCase;

  LoginNotifier(
    this._sendOTPUseCase,
    this._verifyOTPUseCase,
    this._byPhoneOrEmailUseCase,
    this._loginUserUseCase,
  ) : super(const _Initial());

  String _phone = '';
  String otpId = '';

  String get phone => _phone;
  void loginUser(String loginId, String password) async {
    state = const _InProgress();
    final response = await _loginUserUseCase(
      {"UserName": loginId, "Password": password},
    );
    response.fold(
      (l) {
        Logger().e(l.message);
        state = _Error(l.message);
      },
      (r) {
        registerUser(r);
        state = const _Success();
      },
    );
  }

  void loginUserWithOTP(String phone) async {
    _phone = phone;
    state = const _InProgress();
    final response = await _sendOTPUseCase({'Phone': phone, 'Source': 'LOGIN_OTP_EVENT'});
    response.fold(
      (l) {
        Logger().e(l);
        state = _Error(l.message);
      },
      (r) {
        otpId = r;
        state = const _OtpGenerated();
      },
    );
  }

  void verifyOTP(String otp) async {
    state = const _VerifyingOTP();
    final response = await _verifyOTPUseCase({'code': otp}, otpId);
    response.fold(
      (l) {
        Logger().e(l.message);
        state = _OtpVerificationError(l.message);
      },
      (r) {
        _getUserInfo(_phone);
        Logger().d(r);
      },
    );
  }

  void _getUserInfo(String phoneOrEmail) async {
    final user = await _byPhoneOrEmailUseCase(phoneOrEmail);
    user.fold(
      (l) {
        Logger().e(l);
        state = _Error(l.message);
      },
      (r) {
        registerUser(r);
        state = const _OtpVerified();
      },
    );
  }
}
