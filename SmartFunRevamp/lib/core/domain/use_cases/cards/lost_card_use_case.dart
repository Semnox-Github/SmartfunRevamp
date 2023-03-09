import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class LostCardUseCase {
  final CardsRepository _repository;
  LostCardUseCase(this._repository);
  Future<Either<Failure, void>> call(Map<String, dynamic> body) async {
    return await _repository.lostCard(body);
  }
}
