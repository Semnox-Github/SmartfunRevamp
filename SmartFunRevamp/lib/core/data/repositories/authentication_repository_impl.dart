import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final SmartFunApi _api;

  AuthenticationRepositoryImpl(this._api);
  @override
  Future<Either<Failure, CustomerDTO>> loginUser(Map<String, dynamic> body) async {
    try {
      final response = await _api.loginUser(body);
      return Right(response.data);
    } on DioError catch (e) {
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
    } on DioError catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }

  @override
  Future<Either<Failure, void>> getUserMetaData() async {
    try {
      final response = await _api.getSignUpMetadata();
      Logger().d(response);
      return const Right(null);
    } on DioError catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }

  @override
  Future<Either<Failure, String>> sendOTP(Map<String, dynamic> body) async {
    try {
      final response = await _api.sendOTP(body);
      Logger().d(response.data.toJson());
      return Right(response.data.id.toString());
    } on DioError catch (e) {
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
    } on DioError catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
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
    } on DioError catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }

  @override
  Future<Either<Failure, String>> getExecutionController(int siteId) async {
    try {
      final response = await _api.getExecutionController(siteId);
      final token = response.response.headers.value(HttpHeaders.authorizationHeader) ?? '';
      return Right(token);
    } on DioError catch (e) {
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
    } on DioError catch (e) {
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
  Future<Either<Failure, void>> getAppConfigurations(int siteId) async {
    try {
      await _api.getAppConfiguration(siteId);
      return const Right(null);
    } on DioError catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }
}
