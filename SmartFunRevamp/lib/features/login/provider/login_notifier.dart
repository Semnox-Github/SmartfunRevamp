import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_execution_context_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_user_by_phone_or_email_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/login_user_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/send_otp_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/verify_otp_use_case.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:semnox/core/domain/use_cases/select_location/get_all_sites_use_case.dart';
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
    Get.find<GetAllSitesUseCase>(),
    Get.find<LocalDataSource>(),
  ),
);

class LoginNotifier extends StateNotifier<LoginState> {
  final SendOTPUseCase _sendOTPUseCase;
  final VerifyOTPUseCase _verifyOTPUseCase;
  final GetUserByPhoneOrEmailUseCase _byPhoneOrEmailUseCase;
  final LoginUserUseCase _loginUserUseCase;
  final GetExecutionContextUseCase _getExecutionContextUseCase;
  final GetAllSitesUseCase _getAllSitesUseCase;
  final LocalDataSource _localDataSource;

  LoginNotifier(
    this._sendOTPUseCase,
    this._verifyOTPUseCase,
    this._byPhoneOrEmailUseCase,
    this._loginUserUseCase,
    this._getExecutionContextUseCase,
    this._getAllSitesUseCase,
    this._localDataSource,
  ) : super(const _Initial());

  String _phone = '';
  String otpId = '';
  SiteViewDTO? selectedSite;
  String get phone => _phone;
  void loginUser(String loginId, String password) async {
    state = const _InProgress();
    //TODO:Extract this to another function that should be called before any type of login
    final selectedSiteResponse = await _localDataSource.retrieveCustomClass(LocalDataSource.kSelectedSite);
    selectedSiteResponse.fold(
      (l) => Logger().e(l.message),
      (r) => selectedSite = SiteViewDTO.fromJson(r),
    );

    final response = await _loginUserUseCase(
      {
        "UserName": loginId,
        "Password": password,
      },
    );
    response.fold(
      (l) {
        Logger().e(l.message);
        state = _Error(l.message);
      },
      (r) async {
        registerUser(r);
        await getNewToken();
        _getSites(const _Success());
      },
    );
  }

  void loginUserWithOTP(String phoneOrEmail) async {
    state = const _InProgress();
    _phone = phoneOrEmail;
    final response = await _sendOTPUseCase({phoneOrEmail.contains('@') ? 'EmailId' : 'Phone': phoneOrEmail, 'Source': 'LOGIN_OTP_EVENT'});
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
      (r) async {
        registerUser(r);
        await getNewToken();
        _getSites(const _OtpVerified());
      },
    );
  }

  Future<void> getNewToken() async {
    final response = await _getExecutionContextUseCase(selectedSite?.siteId ?? 0);
    response.fold(
      (l) {
        Logger().e(l);
        state = _Error(l.message);
      },
      (r) {
        Get.replace<SmartFunApi>(SmartFunApi('', r));
      },
    );
  }

  void _getSites(LoginState nextState) async {
    final response = await _getAllSitesUseCase();
    response.fold(
      (l) => state = _Error(l.message),
      (r) {
        if (r.length > 1 && selectedSite == null) {
          state = const _SelectLocationNeeded();
        } else {
          state = nextState;
        }
      },
    );
  }
}
