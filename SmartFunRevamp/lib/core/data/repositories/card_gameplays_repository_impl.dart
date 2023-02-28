import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/gameplays/account_gameplays.dart';

import 'package:semnox/core/domain/repositories/card_gameplays_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class CardGameplaysRepositoryImpl implements CardGameplaysRepository {
  final SmartFunApi _api;

  CardGameplaysRepositoryImpl(this._api);

  @override
    Future<Either<Failure, List<AccountGameplays>>> getAccountGamePlays({
      int accountId = 0,
      int urlId = 0,
    }) async {
      try {
        final response = await _api.getAccountGamePlays(accountId, urlId);
        
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