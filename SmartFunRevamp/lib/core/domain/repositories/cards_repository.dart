import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';

import 'package:semnox/core/errors/failures.dart';

abstract class CardsRepository {
  Future<Either<Failure, CardDetails>> getCardDetails(String accountNumber);
  Future<Either<Failure, List<CardDetails>>> getCards(String userId);
}
