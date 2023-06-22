import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/membership/membership_info.dart';
import 'package:semnox/core/domain/entities/membership/membership_tier.dart';
import 'package:semnox/core/domain/repositories/membership_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class MembershipRepositoryImpl implements MembershipRepository {
  final SmartFunApi _api;

  MembershipRepositoryImpl(this._api);
  @override
  Future<Either<Failure, MembershipInfo>> getUserMembershipInfo(int customerId) async {
    try {
      final response = await _api.getMembershipInfo(customerId);
      return Right(response.data);
    } on DioException catch (e) {
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

  @override
  Future<Either<Failure, List<MembershipTier>>> getMembershipContainer(int siteId) async {
    try {
      final response = await _api.getMembershipContainer(siteId);
      response.membershipContainerDTOList.firstWhere((element) => element.nextMembershipIdList.isEmpty).nextMembershipIdList.addAll([9999]);
      response.membershipContainerDTOList.sort(
        (a, b) => a.nextMembershipIdList.first.compareTo(b.nextMembershipIdList.first),
      );
      return Right(response.membershipContainerDTOList);
    } on DioException catch (e) {
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
