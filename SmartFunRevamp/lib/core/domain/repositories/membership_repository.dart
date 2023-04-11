import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class MembershipRepository {
  Future<Either<Failure, void>> getMembershipInfo(int customerId);
}
