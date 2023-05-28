// ignore_for_file: unused_field

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/use_cases/authentication/delete_profile_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_execution_context_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_user_by_phone_or_email_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/login_user_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/send_otp_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/verify_otp_use_case.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:semnox/di/injection_container.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

part 'login_state.dart';
part 'login_notifier.freezed.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(
    Get.find<SendOTPUseCase>(),
    Get.find<VerifyOTPUseCase>(),
    Get.find<GetUserByPhoneOrEmailUseCase>(),
    Get.find<LoginUserUseCase>(),
    Get.find<GetExecutionContextUseCase>(),
    Get.find<LocalDataSource>(),
    Get.find<DeleteProfileUseCase>(),
  ),
);

class LoginNotifier extends StateNotifier<LoginState> {
  final SendOTPUseCase _sendOTPUseCase;
  final VerifyOTPUseCase _verifyOTPUseCase;
  final GetUserByPhoneOrEmailUseCase _byPhoneOrEmailUseCase;
  final LoginUserUseCase _loginUserUseCase;
  final GetExecutionContextUseCase _getExecutionContextUseCase;
  final DeleteProfileUseCase _deleteProfileUseCase;

  final LocalDataSource _localDataSource;

  LoginNotifier(
    this._sendOTPUseCase,
    this._verifyOTPUseCase,
    this._byPhoneOrEmailUseCase,
    this._loginUserUseCase,
    this._getExecutionContextUseCase,
    this._localDataSource,
    this._deleteProfileUseCase,
  ) : super(const _Initial());

  String _phone = '';
  String otpId = '';
  String? previousUserId;
  SiteViewDTO? selectedSite;
  String get phone => _phone;

  void loginUser(String loginId, String password) async {
    state = const _InProgress();
    _phone = loginId;
    final selectedLocationResponse = await _localDataSource.retrieveCustomClass(LocalDataSource.kSelectedSite);
    selectedLocationResponse.fold(
      (l) => Logger().e('No site has been selected'),
      (r) => selectedSite = SiteViewDTO.fromJson(r),
    );
    previousUserId = await _localDataSource.retrieveValue<String>(LocalDataSource.kUserId);
    final loginResponse = await _loginUserUseCase(
      {
        "UserName": loginId,
        "Password": password,
      },
    );
    //TODO:Execution context no changing token
    loginResponse.fold(
      (l) => state = _Error(l.message),
      (customerDTO) async {
        registerUser(customerDTO);
        await _localDataSource.saveValue(LocalDataSource.kUserId, customerDTO.id.toString());
        if (selectedSite == null || previousUserId != customerDTO.id.toString()) {
          state = const _SelectLocationNeeded();
        } else {
          getNewToken();
        }
      },
    );
  }

  void _getUserInfo(String phoneOrEmail) async {
    final selectedLocationResponse = await _localDataSource.retrieveCustomClass(LocalDataSource.kSelectedSite);
    selectedLocationResponse.fold(
      (l) => Logger().e('No site has been selected'),
      (r) => selectedSite = SiteViewDTO.fromJson(r),
    );
    final response = await _byPhoneOrEmailUseCase(phoneOrEmail);
    response.fold(
      (l) {
        Logger().e(l);
        state = _Error(l.message);
      },
      (r) async {
        registerUser(r);
        await _localDataSource.saveValue(LocalDataSource.kUserId, r.id.toString());
        if (selectedSite == null || previousUserId != r.id.toString()) {
          state = const _SelectLocationNeeded();
        } else {
          getNewToken();
        }
      },
    );
  }

  Future<void> getNewToken() async {
    final response = await _getExecutionContextUseCase(selectedSite!.siteId!);
    response.fold(
      (l) {
        state = _Error(l.message);
      },
      (r) {
        Get.replace<SmartFunApi>(SmartFunApi('', r));
        state = const _Success();
      },
    );
  }

//NOTE:925961 Default OTP
  void loginUserWithOTP(String phoneOrEmail) async {
    state = const _InProgress();
    _phone = phoneOrEmail;
    final response = await _sendOTPUseCase({phoneOrEmail.contains('@') ? 'EmailId' : 'Phone': phoneOrEmail, 'Source': 'LOGIN_OTP_EVENT'});
    state = response.fold(
      (l) {
        Logger().e(l);
        return _Error(l.message);
      },
      (r) {
        otpId = r;
        return const _OtpGenerated();
      },
    );
  }

  void resendOtp() async {
    state = const _InProgress();
    final response = await _sendOTPUseCase({_phone.contains('@') ? 'EmailId' : 'Phone': _phone, 'Source': 'LOGIN_OTP_EVENT'});
    state = response.fold(
      (l) => _Error(l.message),
      (r) => const _OtpResend(),
    );
  }

  void resendDeleteOtp() async {
    // ignore: unused_local_variable
    final response = await _sendOTPUseCase({_phone.contains('@') ? 'EmailId' : 'Phone': _phone, 'Source': 'Customer_Delete_Otp_Event'});
  }

  void deleteProfile() async {
    // ignore: unused_local_variable
    final response = await _deleteProfileUseCase();
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
      },
    );
  }

  void verifyDeleteOTP(String otp) async {
    state = const _VerifyingOTP();
    final response = await _verifyOTPUseCase({'code': otp}, otpId);
    response.fold(
      (l) {
        Logger().e(l.message);
        state = _OtpVerificationError(l.message);
      },
      (r) {
        state = const _OtpVerified();
      },
    );
  }
}
