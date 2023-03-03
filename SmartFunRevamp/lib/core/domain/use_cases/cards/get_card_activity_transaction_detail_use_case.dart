import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/card_details/card_activity_details.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetCardActivityTransactionDetailUseCase {
  final CardsRepository _repository;
  GetCardActivityTransactionDetailUseCase(this._repository);
  Future<Either<Failure, CardActivityDetails>> call(String transactionId, bool buildReceipt) async {
    return await _repository.getCardActivityTransactionDetail(transactionId, buildReceipt);
  }
}
