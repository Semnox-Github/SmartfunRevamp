import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:semnox/features/login/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final SmartFunApi _api;

  AuthenticationRepositoryImpl(this._api);
  @override
  Future<Either<Failure, void>> loginUser(Map<String, dynamic> body) async {
    try {
      final response = await _api.loginUser(body);
      Logger().d(response);
      return const Right(null);
    } on DioError catch (e) {
      Logger().e(e);
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }
}
