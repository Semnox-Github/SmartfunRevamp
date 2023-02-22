import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/account/account_detail.dart';
import 'package:semnox/core/domain/repositories/account_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class AccountRepositoryImpl implements AccountRepository {
  final SmartFunApi _api;

  AccountRepositoryImpl(this._api);

  @override
    Future<Either<Failure, List<AccountDetail>>> getAccountDetails({
      int accountId = 0,
      int urlId = 0,
    }) async {
      try {
        final response = await _api.getAccountDetails();
        
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
}