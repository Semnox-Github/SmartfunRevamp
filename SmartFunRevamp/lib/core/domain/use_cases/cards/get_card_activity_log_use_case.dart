import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/card_details/card_activity.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetCardActivityLogUseCase {
  final CardsRepository _repository;
  GetCardActivityLogUseCase(this._repository);
  Future<Either<Failure, List<CardActivity>>> call(String cardId) async {
    return await _repository.getCardActivityLog(cardId);
  }
}
