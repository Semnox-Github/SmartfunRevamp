// ignore_for_file: unused_field

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/use_cases/authentication/delete_profile_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_execution_context_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_user_by_phone_or_email_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/login_user_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/send_otp_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/verify_email_exists_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/verify_otp_use_case.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:semnox/core/domain/use_cases/config/get_parfait_defaults_use_case.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/di/injection_container.dart';
import 'package:semnox/features/splash/splashscreen.dart';
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
    Get.find<GetParafaitDefaultsUseCase>(),
    Get.find<VerifyEmailExistsUseCase>(),
  ),
);

class LoginNotifier extends StateNotifier<LoginState> {
  final SendOTPUseCase _sendOTPUseCase;
  final VerifyOTPUseCase _verifyOTPUseCase;
  final GetUserByPhoneOrEmailUseCase _byPhoneOrEmailUseCase;
  final LoginUserUseCase _loginUserUseCase;
  final GetExecutionContextUseCase _getExecutionContextUseCase;
  final DeleteProfileUseCase _deleteProfileUseCase;
  final GetParafaitDefaultsUseCase _getParafaitDefaultsUseCase;
  final VerifyEmailExistsUseCase _verifyEmailExistsUseCase;

  final LocalDataSource _localDataSource;

  LoginNotifier(
    this._sendOTPUseCase,
    this._verifyOTPUseCase,
    this._byPhoneOrEmailUseCase,
    this._loginUserUseCase,
    this._getExecutionContextUseCase,
    this._localDataSource,
    this._deleteProfileUseCase,
    this._getParafaitDefaultsUseCase,
    this._verifyEmailExistsUseCase,
  ) : super(const _Initial());

  String _phone = '';
  String otpId = '';
  String? previousUserId;
  SiteViewDTO? selectedSite;
  String get phone => _phone;
  ParafaitDefaultsResponse? parafaitDefault;
  String? defaultSiteId;

  void loginUser(String loginId, String password) async {
    // setDefaultSite();
    state = const _InProgress();
    _phone = loginId;
    final selectedLocationResponse = await _localDataSource
        .retrieveCustomClass(LocalDataSource.kSelectedSite);
    selectedLocationResponse.fold(
      (l) => Logger().e('No site has been selected'),
      (r) {
        Logger().d(r);
        selectedSite = SiteViewDTO.fromJson(r);
      },
    );
    previousUserId =
        await _localDataSource.retrieveValue<String>(LocalDataSource.kUserId);
    final loginResponse = await _loginUserUseCase(
      {
        "UserName": loginId,
        "Password": password,
      },
    );
    loginResponse.fold(
      (l) => state = _Error(l.message),
      (customerDTO) async {
        registerUser(customerDTO);
        registerLoggedUser(customerDTO);
        await _localDataSource.saveValue(
            LocalDataSource.kUserId, customerDTO.id.toString());
        if (customerDTO.verified != true) {
          state = const _CustomerVerificationNeeded();
        } else if (selectedSite?.siteName == null ||
            (previousUserId != customerDTO.id.toString() &&
                previousUserId != null) /*&& defaultSiteId.isNullOrEmpty()*/) {
          state = const _SelectLocationNeeded();
        } else {
          getNewToken();
        }
      },
    );
  }

  //TODO:Ask what is this for
  void setDefaultSite() async {
    //reading defaults
    final defaults = await _getParafaitDefaultsUseCase(0);
    defaults.fold(
      (l) => null,
      (r) => parafaitDefault = r,
    );
    //reading default site
    defaultSiteId = parafaitDefault
        ?.getDefault(ParafaitDefaultsResponse.virtualStoreSiteId);
    //if the default site is set then save it
    if (!defaultSiteId.isNullOrEmpty()) {
      selectedSite = SiteViewDTO(
          siteId: int.parse(defaultSiteId!),
          openDate: DateTime.now(),
          closureDate: DateTime.now());
      await _localDataSource.saveCustomClass(
          LocalDataSource.kSelectedSite, selectedSite!.toJson());
    }
  }

  void setSite(SiteViewDTO site) async {
    selectedSite = site;
  }

  void saveSelectedSite() async {
    await _localDataSource.saveCustomClass(
        LocalDataSource.kSelectedSite, selectedSite!.toJson());
  }

  void _getUserInfo(String phoneOrEmail) async {
    //setDefaultSite();
    final selectedLocationResponse = await _localDataSource
        .retrieveCustomClass(LocalDataSource.kSelectedSite);
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
        await _localDataSource.saveValue(
            LocalDataSource.kUserId, r.id.toString());
        if (r.verified != true) {
          state = const _CustomerVerificationNeeded();
        } else if (selectedSite == null &&
            previousUserId != null &&
            previousUserId !=
                r.id.toString() /*&& defaultSiteId.isNullOrEmpty()*/) {
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
  void validateEmailOrPhoneExists(String phoneOrEmail) async {
    state = const _InProgress();
    _phone = phoneOrEmail;
    final userExists = await _verifyEmailExistsUseCase(phoneOrEmail);
    userExists.fold(
      (l) => state = _Error(
          '${phoneOrEmail.contains('@') ? 'Email' : 'Phone'} not registered'),
      (r) {
        if (r) {
          loginUserWithOTP(phoneOrEmail);
        } else {
          state = _Error(
              '${phoneOrEmail.contains('@') ? 'Email' : 'Phone'} not registered');
        }
      },
    );
  }

  void loginUserWithOTP(String phoneOrEmail) async {
    state = const _InProgress();
    final response = await _sendOTPUseCase({
      phoneOrEmail.contains('@') ? 'EmailId' : 'Phone': phoneOrEmail,
      'Source': 'LOGIN_OTP_EVENT'
    });
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
    final response = await _sendOTPUseCase({
      _phone.contains('@') ? 'EmailId' : 'Phone': _phone,
      'Source': 'LOGIN_OTP_EVENT'
    });
    state = response.fold(
      (l) => _Error(l.message),
      (r) {
        otpId = r;
        return const _OtpResend();
      },
    );
  }

  void resendDeleteOtp(String phoneOrEmail) async {
    // ignore: unused_local_variable
    final response = await _sendOTPUseCase({
      _phone.contains('@') ? 'EmailId' : 'Phone': phoneOrEmail,
      'Source': 'Customer_Delete_Otp_Event'
    });
    state = response.fold(
      (l) => _Error(l.message),
      (r) {
        otpId = r;
        return const _OtpResend();
      },
    );
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
