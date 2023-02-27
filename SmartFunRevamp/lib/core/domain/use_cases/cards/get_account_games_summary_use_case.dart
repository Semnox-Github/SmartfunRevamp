import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetAccountGamesSummaryUseCase {
  final CardsRepository _repository;
  GetAccountGamesSummaryUseCase(this._repository);
  Future<Either<Failure, void>> call(String userId) async {
    return await _repository.getAccountGamesSummary(userId);
  }
}
