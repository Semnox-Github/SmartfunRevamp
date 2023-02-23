import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/card_details/bonus_summary.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetBonusSummaryUseCase {
  final CardsRepository _repository;
  GetBonusSummaryUseCase(this._repository);
  Future<Either<Failure, List<AccountCreditPlusDTOList>>> call(String accountNumber) async {
    return await _repository.getBonusSummary(accountNumber);
  }
}
