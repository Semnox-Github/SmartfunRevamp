import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/transfer/transfer_balance.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class TransferBalanceUseCase {
  final CardsRepository _repository;
  TransferBalanceUseCase(this._repository);
  Future<Either<Failure, String>> call(TransferBalance transferBalance) async {
    return await _repository.transferBalance(transferBalance);
  }
}
