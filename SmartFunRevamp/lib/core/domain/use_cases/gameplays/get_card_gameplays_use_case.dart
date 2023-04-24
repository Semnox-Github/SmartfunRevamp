import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/gameplays/account_gameplays.dart';
import 'package:semnox/core/domain/repositories/card_gameplays_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetCardGameplaysUseCase {
  final CardGameplaysRepository _repository;
  GetCardGameplaysUseCase(this._repository);
  Future<Either<Failure, List<AccountGameplays>>> call(int accountId) async {
    return await _repository.getAccountGamePlays(accountId: accountId);
  }
}
