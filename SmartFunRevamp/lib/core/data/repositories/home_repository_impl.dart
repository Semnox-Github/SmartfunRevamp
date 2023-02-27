import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/home/card_details.dart';
import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/home_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class HomeRepositoryImpl implements HomeRepository {
  final SmartFunApi _api;

  HomeRepositoryImpl(this._api);
  @override
  Future<Either<Failure, List<CardDetails>>> getCardDetails(String userId) async {
    try {
      final response = await _api.getUserCards(userId);
      Logger().d('Tarjetas ${response.data.length}');
      return Right(response.data);
    } on DioError catch (e) {
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
}
