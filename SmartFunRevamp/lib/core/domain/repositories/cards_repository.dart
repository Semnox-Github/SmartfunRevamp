import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/card_details/account_credit_plus_dto_list.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';

import 'package:semnox/core/errors/failures.dart';

abstract class CardsRepository {
  Future<Either<Failure, CardDetails>> getCardDetails(String accountNumber);
  Future<Either<Failure, List<AccountCreditPlusDTOList>>> getBonusSummary(String accountNumber);
  Future<Either<Failure, List<CardDetails>>> getCards(String userId);
  Future<Either<Failure, void>> getAccountGamesSummary(String userId);
  Future<Either<Failure, void>> linkCardToUser(String cardNumber, String userId);
}
