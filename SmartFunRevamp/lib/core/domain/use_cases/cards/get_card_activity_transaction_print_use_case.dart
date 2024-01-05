import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/orders/transaction_print.dart';

import '../../../errors/failures.dart';
import '../../repositories/cards_repository.dart';

class GetCardActivityTransactionPrintUseCase {
  final CardsRepository _repository;
  GetCardActivityTransactionPrintUseCase(this._repository);
  Future<Either<Failure, TransactionPrint>> call(String transactionId, bool buildReceipt) async {
    return await _repository.getCardActivityTransactionPrint(transactionId);
  }
}