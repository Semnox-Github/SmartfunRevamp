// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:glutton/glutton.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/use_cases/authentication/check_notification_token_registered.dart';
import 'package:semnox/core/domain/use_cases/authentication/delete_profile_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_execution_context_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_user_by_phone_or_email_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/login_user_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/send_otp_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/verify_email_exists_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/verify_otp_use_case.dart';
import 'package:semnox/core/domain/use_cases/config/get_parfait_defaults_use_case.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/splash/splashscreen.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

part 'login_notifier.freezed.dart';
part 'login_state.dart';

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
  SiteViewDTO? defaultSite;
  String get phone => _phone;
  ParafaitDefaultsResponse? parafaitDefault;
  String? defaultSiteId;
  CustomerDTO? _loggedUser;

  void loginUser(String loginId, String password) async {
    setDefaultOrSelectedSite();
    state = const _InProgress();
    _phone = loginId;
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
        _loggedUser = customerDTO;
        registerLoggedUser(customerDTO);
        final CheckNotificationTokenRegisteredUseCase check =
            Get.find<CheckNotificationTokenRegisteredUseCase>();
        await check(userId: _loggedUser?.id ?? -1);
        await _localDataSource.saveValue(
            LocalDataSource.kUserId, customerDTO.id.toString());
        if (customerDTO.verified != true) {
          if (defaultSite?.siteId != null) {
            getNewToken();
          }
          state = _CustomerVerificationNeeded(customerDTO);
        } else if (defaultSite?.siteId == null &&
            (selectedSite?.siteId == null ||
                (previousUserId != customerDTO.id.toString() &&
                    previousUserId != null))) {
          state = _SelectLocationNeeded(customerDTO);
        } else {
          getNewToken();
        }
      },
    );
  }

  void setDefaultSite(int siteId) async {
    //reading defaults
    final defaults = await _getParafaitDefaultsUseCase(siteId);
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
          LocalDataSource.kDefaultSite, selectedSite?.toJson() ?? {});
      await _localDataSource.saveCustomClass(
          LocalDataSource.kSelectedSite, selectedSite?.toJson() ?? {});
    }
  }

  void setSite(SiteViewDTO site) async {
    selectedSite = site;
  }

  void saveSelectedSite() async {
    await _localDataSource.saveCustomClass(
        LocalDataSource.kSelectedSite, selectedSite?.toJson() ?? {});
  }

  void setDefaultOrSelectedSite() async {
    final selectedLocationResponse = await _localDataSource
        .retrieveCustomClass(LocalDataSource.kSelectedSite);
    final defaultLocationResponse = await _localDataSource
        .retrieveCustomClass(LocalDataSource.kSelectedSite);
    defaultLocationResponse.fold(
      (l) => Logger().e('No site has been selected'),
      (r) {
        selectedSite = SiteViewDTO.fromJson(r);
        defaultSite = SiteViewDTO.fromJson(r);
      },
    );
    if (selectedSite == null) {
      selectedLocationResponse.fold(
        (l) => Logger().e('No site has been selected'),
        (r) => selectedSite = SiteViewDTO.fromJson(r),
      );
    }
  }

  void _getUserInfo(String phoneOrEmail) async {
    setDefaultOrSelectedSite();

    previousUserId =
        await _localDataSource.retrieveValue<String>(LocalDataSource.kUserId);
    final response = await _byPhoneOrEmailUseCase(phoneOrEmail);
    response.fold(
      (l) {
        Logger().e(l);
        state = _Error(l.message);
      },
      (r) async {
        await _localDataSource.saveValue(
            LocalDataSource.kUserId, r.id.toString());
        registerLoggedUser(r);
        _loggedUser = r;
        if (r.verified != true) {
          state = _CustomerVerificationNeeded(r);
        } else {
          if (selectedSite == null) {
            state = _SelectLocationNeeded(r);
          } else {
            await getNewToken();
          }
        }
      },
    );
  }

  Future<void> getNewToken() async {
    // final response = await _getExecutionContextUseCase(selectedSite.siteId!);
    final response = await _getExecutionContextUseCase(selectedSite?.siteId ?? 0);
    response.fold(
      (l) {
        state = _Error(l.message);
      },
      (r) async {
        Get.replace<SmartFunApi>(SmartFunApi('', r));
        state = _Success(_loggedUser);
      },
    );
  }

//NOTE:925961 Default OTP
  void validateEmailOrPhoneExists(String phoneOrEmail) async {
    state = const _InProgress();
    _phone = phoneOrEmail;
    final userExists = await _verifyEmailExistsUseCase(phoneOrEmail);
    debugPrint("user exists $userExists");
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
    _phone = phoneOrEmail;
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
    await _deleteProfileUseCase();
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
        Logger().d('Getting User Info');
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
        try {
          Glutton.digest(LocalDataSource.kUserId);
          Glutton.digest(LocalDataSource.kUser);
          Glutton.digest(LocalDataSource.kSelectedSite);
          Glutton.digest(LocalDataSource.kTransactionId);
        } catch (e) {
          Logger().e(e);
        }
        state = const _OtpVerified();
      },
    );
  }
}
