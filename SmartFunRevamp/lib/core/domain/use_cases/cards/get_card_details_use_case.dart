import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetCardDetailsUseCase {
  final CardsRepository _repository;
  GetCardDetailsUseCase(this._repository);
  Future<Either<Failure, CardDetails>> call(String accountNumber) async {
    return await _repository.getCardDetails(accountNumber);
  }
}
