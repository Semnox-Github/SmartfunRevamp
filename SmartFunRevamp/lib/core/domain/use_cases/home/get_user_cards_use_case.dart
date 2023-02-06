import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/home/card_details.dart';
import 'package:semnox/core/domain/repositories/home_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetUserCardsUseCase {
  final HomeRepository _repository;
  GetUserCardsUseCase(this._repository);
  Future<Either<Failure, List<CardDetails>>> call(String userId) async {
    return await _repository.getCardDetails(userId);
  }
}
