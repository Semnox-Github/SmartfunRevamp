import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/card_details/account_credit_plus_dto_list.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetBonusSummaryUseCase {
  final CardsRepository _repository;
  GetBonusSummaryUseCase(this._repository);
  Future<Either<Failure, List<AccountCreditPlusDTOList>>> call(String accountNumber) async {
    return await _repository.getBonusSummary(accountNumber);
  }
}
