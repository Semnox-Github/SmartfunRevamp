import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/repositories/membership_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class MembershipRepositoryImpl implements MembershipRepository {
  final SmartFunApi _api;

  MembershipRepositoryImpl(this._api);
  @override
  Future<Either<Failure, void>> getMembershipInfo(int customerId) async {
    try {
      await _api.getMembershipInfo(customerId);
      await _api.getMembershipContainer(1040);
      Logger().d(null);
      return const Right(null);
    } on DioError catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    } catch (e) {
      Logger().e(e);
      return Left(ServerFailure('This card has no activities'));
    }
  }
}
