import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class TransferBalanceUseCase {
  final CardsRepository _repository;
  TransferBalanceUseCase(this._repository);
  Future<Either<Failure, String>> call(Map<String, dynamic> body) async {
    return await _repository.transferBalance(body);
  }
}
