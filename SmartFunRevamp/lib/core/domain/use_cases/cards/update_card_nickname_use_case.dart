import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class UpdateCardNicknameUseCase {
  final CardsRepository _repository;
  UpdateCardNicknameUseCase(this._repository);
  Future<Either<Failure, void>> call(String cardNumber, String userId) async {
    return await _repository.updateCardNickname(cardNumber, userId);
  }
}
