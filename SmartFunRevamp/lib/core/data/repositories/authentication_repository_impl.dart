import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/entities/notifications_register/notification_register_entity.dart';
import 'package:semnox/core/domain/entities/sign_up/user_metadata.dart';
import 'package:semnox/core/domain/entities/splash_screen/app_config_response.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/di/injection_container.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final SmartFunApi _api;
  final LocalDataSource _glutton;

  AuthenticationRepositoryImpl(this._api, this._glutton);
  @override
  Future<Either<Failure, CustomerDTO>> loginUser(
      Map<String, dynamic> body) async {
    try {
      final response = await _api.loginUser(body);
      _glutton.saveUser(response.data);
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, CustomerDTO>> signUpUser(
      Map<String, dynamic> body) async {
    try {
      final response = await _api.signUpUser(body);
      registerUser(response.data);
      await _glutton.saveUser(response.data);
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, List<CustomerUIMetaData>>> getUserMetaData(
      int siteId) async {
    try {
      final response = await _api.getSignUpMetadata(siteId.toString());
      final uiMetadataList = response.data.customerUIMetadataContainerDTOList;
      uiMetadataList
          .removeWhere((element) => element.customerFieldName == 'USERNAME');
      uiMetadataList
          .sort((a, b) => a.customerFieldOrder.compareTo(b.customerFieldOrder));
      return Right(uiMetadataList);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, String>> sendOTP(Map<String, dynamic> body) async {
    try {
      final response = await _api.sendOTP(body);
      Logger().d(response.data.toJson());
      return Right(response.data.id.toString());
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOTP(
      Map<String, dynamic> body, String otpId) async {
    try {
      await _api.validateOTP(body, otpId);
      return const Right(true);
    } on Exception catch (e) {
      return Left(e.handleException(errorMessage404: 'Invalid OTP'));
    }
  }

  @override
  Future<Either<Failure, CustomerDTO>> getUserByPhoneOrEmail(
      String phoneOrEmail) async {
    try {
      final response = await _api.getCustomerByPhoneorEmail(phoneOrEmail);
      _glutton.saveUser(response.data.first);
      return Right(response.data.first);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, String>> getUserExecutionController(int siteId) async {
    try {
      final response = await _api.getExecutionContext(siteId: siteId);
      final token =
          response.response.headers.value(HttpHeaders.authorizationHeader) ??
              '';
      return Right(token);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, int>> getConfigExecutionController() async {
    try {
      final response = await _api.getExecutionContext();
      final data = Map.from(response.data);
      return Right(data['data']['SiteId'] as int);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, void>> sendResetPasswordLink(
      String phoneOrEmail) async {
    try {
      final userInfo = await _api.getCustomerByPhoneorEmail(phoneOrEmail);
      await _api.sendResetPasswordLink({"UserName": userInfo.data.first.email});
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.handleException(errorMessage404: 'Email Not Found'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProfile() async {
    try {
      final user = Get.find<CustomerDTO>();
      final int id = user.id?.toInt() ?? 0;
      await _api.deleteProfile(id);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.handleException(errorMessage: 'User Not Found'));
    }
  }

  @override
  Future<Either<Failure, AppConfigResponse>> getAppConfig(int siteId) async {
    try {
      final response = await _api.getAppConfiguration(siteId);
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException(errorMessage: 'Config Not Found'));
    }
  }

  @override
  Future<Either<Failure, HomePageCMSResponse>> getHomePageCMS() async {
    try {
      final response = await _api.getHomePageCMS();
      return Right(response.data.first);
    } on Exception catch (e) {
      return Left(e.handleException(errorMessage: 'CMS Not Found'));
    }
  }

  @override
  Future<Either<Failure, bool>> validateEmail(String email) async {
    try {
      final userInfo = await _api.getCustomerByPhoneorEmail(email);
      return Right(userInfo.data.isNotEmpty);
    } on Exception catch (e) {
      return Left(e.handleException(errorMessage404: 'Email Not Found'));
    }
  }

  @override
  Future<Either<Failure, void>> registerNotificationToken(int userId) async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      List<String> registeredTokens = [];
      try {
        final registeredTokensResponse =
            await _api.checkNotificationTokenRegistered(token!);

        // Logger()
        //     .d("registered token ${registeredTokensResponse.data.toString()}");

        // debugPrint(
        //     "registered token ${registeredTokensResponse.data.toString()}");
        //validate if response has data
        if (!registeredTokensResponse.data.isNullOrEmpty()) {
          registeredTokens = registeredTokensResponse.data
              .map((e) => e.pushNotificationToken)
              .toList();
        }
      } catch (e) {
        Logger().e('error getting registered notification tokens $e');
      }

      debugPrint("registeredToken $registeredTokens");

      if (!registeredTokens.contains(token)) {
        final request = NotificationRegisterEntity(
          -1,
          userId,
          token ?? '',
          Platform.isAndroid ? 'ANDROID' : 'IOS',
        );

        await _api.registerNotificationToken([request]);
      } else {
        Logger().d('Already Registered');
      }
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }
}
