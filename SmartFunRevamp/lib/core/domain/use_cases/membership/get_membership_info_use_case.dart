import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/membership/membership_info.dart';
import 'package:semnox/core/domain/repositories/membership_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetMembershipInfoUseCase {
  final MembershipRepository _repository;
  GetMembershipInfoUseCase(this._repository);
  Future<Either<Failure, MembershipInfo>> call(int userId) async {
    return await _repository.getUserMembershipInfo(userId);
  }
}
