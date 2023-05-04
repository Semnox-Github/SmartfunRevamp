import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/membership/membership_info.dart';
import 'package:semnox/core/domain/entities/membership/membership_tier.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class MembershipRepository {
  Future<Either<Failure, MembershipInfo>> getUserMembershipInfo(int customerId);
  Future<Either<Failure, List<MembershipTier>>> getMembershipContainer(int siteId);
}
