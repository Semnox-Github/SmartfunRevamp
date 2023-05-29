import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/membership/membership_tier.dart';
import 'package:semnox/core/domain/repositories/membership_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetMembershipContainerUseCase {
  final MembershipRepository _repository;
  GetMembershipContainerUseCase(this._repository);
  Future<Either<Failure, List<MembershipTier>>> call(int siteId) async {
    return await _repository.getMembershipContainer(siteId);
  }
}
