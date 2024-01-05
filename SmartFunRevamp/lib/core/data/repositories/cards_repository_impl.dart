import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/card_details/account_credit_plus_dto_list.dart';
import 'package:semnox/core/domain/entities/card_details/account_game_dto_list.dart';
import 'package:semnox/core/domain/entities/card_details/card_activity.dart';
import 'package:semnox/core/domain/entities/card_details/card_activity_details.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/orders/transaction_print.dart';
import 'package:semnox/core/domain/entities/transfer/transfer_balance.dart';
import 'package:semnox/core/domain/repositories/cards_repository.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

import '../../domain/entities/card_details/credit_plus_summary.dart';
import '../../domain/entities/card_details/transaction_details.dart';
import '../../domain/entities/splash_screen/authenticate_system_user.dart';
import '../../domain/entities/transfer/transfer_balance_request.dart';

class CardsRepositoryImpl implements CardsRepository {
  final SmartFunApi _api;

  CardsRepositoryImpl(this._api);
  @override
  Future<Either<Failure, List<CardDetails>>> getCards(String userId) async {
    try {
      final response = await _api.getUserCards(userId);
      List<CardDetails> allCards = response.data;
      //sorting all cards by date (descending)
      allCards.sort((b, a) => (a.expiryDate ?? DateTime.now().toIso8601String())
          .compareTo(b.expiryDate ?? DateTime.now().toIso8601String()));
      //creating 3 copies of the sorted list
      final List<CardDetails> blockedCards = [...allCards];
      final List<CardDetails> expiredCards = [...allCards];
      final List<CardDetails> activeCards = [...allCards];
      //removing all non expired cards
      expiredCards.removeWhere((element) => (!element.isExpired()));
      //removing all expired and non blocked cards
      blockedCards.removeWhere((element) => (!element.isBlocked()));
      blockedCards.removeWhere((element) => (element.isExpired()));
      //removing all expired and blocked cards
      activeCards.removeWhere((element) => (element.isExpired() || element.isBlocked()));
      //adding in desired group order
      final List<CardDetails> sortedCards = [...activeCards, ...blockedCards, ...expiredCards];
      return Right(sortedCards);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, CardDetails>> getCardDetails(String accountNumber) async {
    try {
      final response = await _api.getCardDetails(accountNumber);
      Logger().d('Tarjetas ${response.data.length}');
      return Right(response.data.first);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, List<AccountCreditPlusDTOList>>> getBonusSummary(String accountNumber) async {
    try {
      final response = await _api.getBonusSummary(accountNumber);
      final cleanList = response.data.first.accountCreditPlusDTOList;
      cleanList?.removeWhere((element) => element.periodFrom == null);
      return Right(cleanList ?? []);
    } on Exception catch (e) {
      Logger().e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, List<CreditPlusSummary>>> getBonusCreditSummary(String accountNumber) async {
    try {
      final response = await _api.getCreditPlusSummary(accountNumber);
      // final cleanList = response.data.first.accountCreditPlusDTOList;
      // cleanList?.removeWhere((element) => element.periodFrom == null);
      return Right(response.data);
    } on Exception catch (e) {
      Logger().e(e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, List<AccountGameDTOList>>> getAccountGamesSummary(String accountNumber) async {
    try {
      final response = await _api.getBonusSummary(accountNumber);
      final cleanList = response.data.first.accountGameDTOList;
      cleanList?.removeWhere((element) => element.fromDate == null);
      Logger().d(response.data);
      return Right(cleanList ?? []);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, void>> linkCardToUser(String cardNumber, String userId) async {
    try {
      final cardDetail = await _api.getCardDetails(cardNumber);

      if (cardDetail.data.isEmpty) {
        return Left(ServerFailure('Card has no info'));
      }
      if (cardDetail.data.first.customerId != -1) {
        return Left(ServerFailure('Card is already linked to another user'));
      }

      final response = await _api.linkAccountToCustomer(userId.toString(),{
        "TagNumber": cardNumber
      });

      // final response = await _api.linkCardToCustomer({
      //   "SourceAccountDTO": {"AccountId": cardDetail.data.first.accountId},
      //   "CustomerDTO": {"Id": userId}
      // });
      Logger().d(response.data.toString());
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, List<CardActivity>>> getCardActivityLog(String cardId) async {
    try {
      final response = await _api.getCardActivityDetail(cardId);
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException(errorMessage: 'This card has no activities'));
    }
  }

  @override
  Future<Either<Failure, void>> lostCard(Map<String, dynamic> body) async {
    try {
      await _api.lostCard(body);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, TransactionDetail>> getCardActivityTransactionDetail(
      String transactionId, bool buildReceipt) async {
    try {
      final response = await _api.getTransaction(transactionId);
      return Right(response.data.first);
    } on Exception catch (e) {
      return Left(
          e.handleException(errorMessage: SplashScreenNotifier.getLanguageLabel('This card has no activities')));
    }
  }

  @override
  Future<Either<Failure, TransactionPrint>> getCardActivityTransactionPrint(
      String transactionId) async {
    try {
      final response = await _api.getTransactionPrint(transactionId);
      return Right(response.data.first);
    } on Exception catch (e) {
      return Left(
          e.handleException(errorMessage: SplashScreenNotifier.getLanguageLabel('This card has no activities')));
    }
  }



  @override
  Future<Either<Failure, String>> transferBalance(TransferBalance transferBalance) async {
    try {
      final systemUser = Get.find<SystemUser>();
      if (transferBalance.to.accountId == null) {
        transferBalance.to = (await _api.getCardDetails(transferBalance.to.accountNumber ?? '')).data.first;
      }

      final request = TransferBalanceRequest(
           transferBalance.from.accountId ?? 0,
           transferBalance.to.accountId ?? 0,
           transferBalance.amount.toDouble(),
            DateTime.now().toString(),
          transferBalance.from.accountNumber ?? "",
          transferBalance.to.accountNumber ?? "",
           systemUser.machineId,
           systemUser.userPKId,
          transferBalance.entitlementType.toString()
      );

      final response = await _api.transferBalance(
          [request]
      );

      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, void>> updateCardNickname(int cardId, String nickname) async {
    try {
      await _api.updateCardNickname(
        cardId.toString(),
        {
          "accountId": cardId,
          "accountIdentifier": nickname,
        },
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }
}
