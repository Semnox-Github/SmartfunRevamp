import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/card_details/account_game_dto_list.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetAccountGamesSummaryUseCase {
  final CardsRepository _repository;
  GetAccountGamesSummaryUseCase(this._repository);
  Future<Either<Failure, List<AccountGameDTOList>>> call(String accountNumber) async {
    return await _repository.getAccountGamesSummary(accountNumber);
  }
}
