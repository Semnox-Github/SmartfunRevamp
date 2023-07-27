import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/sign_up/user_metadata.dart';
import 'package:semnox/core/domain/entities/splash_screen/app_config_response.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final SmartFunApi _api;

  AuthenticationRepositoryImpl(this._api);
  @override
  Future<Either<Failure, CustomerDTO>> loginUser(Map<String, dynamic> body) async {
    try {
      final response = await _api.loginUser(body);
      return Right(response.data);
    } on DioException catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }

  @override
  Future<Either<Failure, CustomerDTO>> signUpUser(Map<String, dynamic> body) async {
    try {
      final response = await _api.signUpUser(body);
      return Right(response.data);
    } on DioException catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }

  @override
  Future<Either<Failure, List<CustomerUIMetaData>>> getUserMetaData() async {
    try {
      final response = await _api.getSignUpMetadata(Get.find<ExecutionContextDTO>().siteId.toString());
      final uiMetadataList = response.data.customerUIMetadataContainerDTOList;
      // uiMetadataList.removeWhere((element) => element.customerFieldName == 'TestDownload');
      uiMetadataList.removeWhere((element) => element.customerFieldName == 'USERNAME');
      uiMetadataList.sort((a, b) => a.customerFieldOrder.compareTo(b.customerFieldOrder));
      return Right(uiMetadataList);
    } on DioException catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    } catch (e) {
      Logger().e(e);
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, String>> sendOTP(Map<String, dynamic> body) async {
    try {
      final response = await _api.sendOTP(body);
      Logger().d(response.data.toJson());
      return Right(response.data.id.toString());
    } on DioException catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOTP(Map<String, dynamic> body, String otpId) async {
    try {
      await _api.validateOTP(body, otpId);
      return const Right(true);
    } on DioException catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Invalid OTP'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }

  @override
  Future<Either<Failure, CustomerDTO>> getUserByPhoneOrEmail(String phoneOrEmail) async {
    try {
      final response = await _api.getCustomerByPhoneorEmail(phoneOrEmail);
      return Right(response.data.first);
    } on DioException catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }

  @override
  Future<Either<Failure, String>> getUserExecutionController(int siteId) async {
    try {
      final response = await _api.getExecutionController(siteId: siteId);
      final token = response.response.headers.value(HttpHeaders.authorizationHeader) ?? '';
      return Right(token);
    } on DioException catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }

  @override
  Future<Either<Failure, int>> getConfigExecutionController() async {
    try {
      final response = await _api.getExecutionController();
      final data = Map.from(response.data);
      return Right(data['data']['SiteId'] as int);
    } on DioException catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }

  @override
  Future<Either<Failure, void>> sendResetPasswordLink(String phoneOrEmail) async {
    try {
      final userInfo = await _api.getCustomerByPhoneorEmail(phoneOrEmail);
      await _api.sendResetPasswordLink({"UserName": userInfo.data.first.email});
      return const Right(null);
    } on DioException catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    } catch (e) {
      return Left(ServerFailure('Email not found'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProfile() async {
    try {
      final user = Get.find<CustomerDTO>();
      final int id = user.id?.toInt() ?? 0;
      await _api.deleteProfile(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('User not found'));
    }
  }

  @override
  Future<Either<Failure, AppConfigResponse>> getAppConfig(int siteId) async {
    try {
      final response = await _api.getAppConfiguration(siteId);
      return Right(response.data);
    } catch (e) {
      return Left(ServerFailure('Config Not Found'));
    }
  }

  @override
  Future<Either<Failure, HomePageCMSResponse>> getHomePageCMS() async {
    try {
      final response = await _api.getHomePageCMS();
      return Right(response.data.first);
    } catch (e) {
      return Left(ServerFailure('Email not found'));
    }
  }

  @override
  Future<Either<Failure, bool>> validateEmail(String email) async {
    try {
      final userInfo = await _api.getCustomerByPhoneorEmail(email);
      return Right(userInfo.data.isNotEmpty);
    } on DioException catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    } catch (e) {
      return Left(ServerFailure('Email not found'));
    }
  }
}
