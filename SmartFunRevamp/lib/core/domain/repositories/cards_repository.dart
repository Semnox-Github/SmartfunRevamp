import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/card_details/account_credit_plus_dto_list.dart';
import 'package:semnox/core/domain/entities/card_details/card_activity.dart';
import 'package:semnox/core/domain/entities/card_details/card_activity_details.dart';
import 'package:semnox/core/domain/entities/card_details/account_game_dto_list.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/transfer/transfer_balance.dart';

import 'package:semnox/core/errors/failures.dart';

abstract class CardsRepository {
  Future<Either<Failure, CardDetails>> getCardDetails(String accountNumber);
  Future<Either<Failure, List<AccountCreditPlusDTOList>>> getBonusSummary(String accountNumber);
  Future<Either<Failure, List<CardDetails>>> getCards(String userId);
  Future<Either<Failure, List<AccountGameDTOList>>> getAccountGamesSummary(String accountNumber);
  Future<Either<Failure, void>> linkCardToUser(String cardNumber, String userId);
  Future<Either<Failure, List<CardActivity>>> getCardActivityLog(String cardId);
  Future<Either<Failure, CardActivityDetails>> getCardActivityTransactionDetail(String transactionId, bool buildReceipt);
  Future<Either<Failure, String>> transferBalance(TransferBalance transferBalance);
  Future<Either<Failure, void>> lostCard(Map<String, dynamic> body);
  Future<Either<Failure, void>> updateCardNickname(String cardId, String nickname);
}
