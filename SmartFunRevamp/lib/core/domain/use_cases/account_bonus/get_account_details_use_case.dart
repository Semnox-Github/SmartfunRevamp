import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/account/account_detail.dart';
import 'package:semnox/core/domain/repositories/account_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetAccountDetailsUseCase {
  final AccountRepository _repository;
  GetAccountDetailsUseCase(this._repository);
  Future<Either<Failure, List<AccountDetail>>> call() async {
    return await _repository.getAccountDetails();
  }
}
