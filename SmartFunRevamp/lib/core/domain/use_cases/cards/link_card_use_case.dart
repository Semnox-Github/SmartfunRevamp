import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class LinkCardUseCase {
  final CardsRepository _repository;
  LinkCardUseCase(this._repository);
  Future<Either<Failure, void>> call(String cardNumber, String userId) async {
    return await _repository.linkCardToUser(cardNumber, userId);
  }
}
