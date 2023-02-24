import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';

import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/card_details/account_credit_plus_dto_list.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class CardsRepositoryImpl implements CardsRepository {
  final SmartFunApi _api;

  CardsRepositoryImpl(this._api);
  @override
  Future<Either<Failure, List<CardDetails>>> getCards(String userId) async {
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

  @override
  Future<Either<Failure, CardDetails>> getCardDetails(String accountNumber) async {
    try {
      final response = await _api.getCardDetails(accountNumber);
      Logger().d('Tarjetas ${response.data.length}');
      return Right(response.data.first);
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

  @override
  Future<Either<Failure, List<AccountCreditPlusDTOList>>> getBonusSummary(String accountNumber) async {
    try {
      final response = await _api.getBonusSummary(accountNumber);
      final cleanList = response.data.first.accountCreditPlusDTOList;
      cleanList?.removeWhere((element) => element.periodFrom == null);
      return Right(cleanList ?? []);
    } on DioError catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> getAccountGamesSummary(String userId) async {
    try {
      final response = await _api.getGamesAccountSummart(userId);
      Logger().d(response.data);
      return const Right(null);
    } on DioError catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    } catch (e) {
      rethrow;
    }
  }
}
