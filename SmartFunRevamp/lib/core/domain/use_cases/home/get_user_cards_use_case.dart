import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';

import 'package:semnox/core/errors/failures.dart';

class GetUserCardsUseCase {
  final CardsRepository _repository;
  GetUserCardsUseCase(this._repository);
  Future<Either<Failure, List<CardDetails>>> call(String userId) async {
    return await _repository.getCards(userId);
  }
}
