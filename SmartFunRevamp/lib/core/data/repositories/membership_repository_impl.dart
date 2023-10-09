import 'package:dartz/dartz.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/membership/membership_info.dart';
import 'package:semnox/core/domain/entities/membership/membership_tier.dart';
import 'package:semnox/core/domain/repositories/membership_repository.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/utils/extensions.dart';

class MembershipRepositoryImpl implements MembershipRepository {
  final SmartFunApi _api;

  MembershipRepositoryImpl(this._api);
  @override
  Future<Either<Failure, MembershipInfo>> getUserMembershipInfo(int customerId) async {
    try {
      final response = await _api.getMembershipInfo(customerId);
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, List<MembershipTier>>> getMembershipContainer(int siteId) async {
    try {
      final response = await _api.getMembershipContainer(siteId);
      response.membershipContainerDTOList
          .firstWhere((element) => element.nextMembershipIdList.isEmpty)
          .nextMembershipIdList
          .addAll([9999]);
      response.membershipContainerDTOList.sort(
        (a, b) => a.nextMembershipIdList.first.compareTo(b.nextMembershipIdList.first),
      );
      return Right(response.membershipContainerDTOList);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }
}
