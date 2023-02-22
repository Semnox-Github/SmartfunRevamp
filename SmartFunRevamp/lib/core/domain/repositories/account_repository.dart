import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/account/account_detail.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class AccountRepository {
  Future<Either<Failure, List<AccountDetail>>> getAccountDetails();
}