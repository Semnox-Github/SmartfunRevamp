import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/entities/card_details/account_credit_plus_dto_list.dart';
import 'package:semnox/core/domain/entities/card_details/account_game_dto_list.dart';
import 'package:semnox/core/domain/entities/card_details/card_activity.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/transfer/transfer_balance.dart';
import 'package:semnox/core/domain/use_cases/cards/get_account_games_summary_use_case.dart';
import 'package:semnox/core/domain/use_cases/cards/get_bonus_summary_use_case.dart';
import 'package:semnox/core/domain/use_cases/cards/get_card_activity_log_use_case.dart';
import 'package:semnox/core/domain/use_cases/cards/transfer_balance_use_case.dart';
import 'package:semnox/core/domain/use_cases/cards/lost_card_use_case.dart';

import 'package:semnox/core/domain/use_cases/home/get_user_cards_use_case.dart';
import 'package:semnox/features/membership_info/provider/membership_info_provider.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
part 'cards_state.dart';
part 'cards_provider.freezed.dart';

class CardsProviders {
  static final userCardsProvider = FutureProvider<List<CardDetails>>((ref) async {
    final GetUserCardsUseCase getUserCardsUseCase = Get.find<GetUserCardsUseCase>();
    final user = ref.watch(userProvider);
    final userId = ref.watch(userProvider)?.id ?? -1;
    Logger().d('User -> ${user?.toJson()}');

    final response = await getUserCardsUseCase(userId.toString());
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });
  static final loyaltyPointsBalanceProvider = Provider.autoDispose<int>((ref) {
    final cards = ref.watch(userCardsProvider).value;
    if (cards == null) {
      return 0;
    }
    int loyaltyBalance = 0;
    for (var card in cards) {
      if (card.totalLoyaltyBalance != null) {
        loyaltyBalance += card.totalLoyaltyBalance!.toInt();
      }
    }
    return loyaltyBalance;
  });
  static final loyaltyPointsDetailProvider = FutureProvider.autoDispose<List<CardActivity>>((ref) async {
    final cards = ref.watch(userCardsProvider).value;
    final List<CardActivity> allTransactions = [];
    final GetCardActivityLogUseCase getCardActivityLogUseCase = Get.find<GetCardActivityLogUseCase>();
    if (cards != null) {
      final cardsNumbers = cards.map((e) => e.accountId.toString()).toList();
      for (var cardNumber in cardsNumbers) {
        allTransactions.addAll(
          (await getCardActivityLogUseCase(cardNumber)).fold(
            (l) => [],
            (r) => r,
          ),
        );
      }
      allTransactions.removeWhere((element) => element.amount == null || element.loyaltyPoints == null);
      return allTransactions;
    }
    return [];
  });
  static final userGamesSummaryProvider = FutureProvider.autoDispose<void>((ref) async {
    final GetAccountGamesSummaryUseCase getAccountGamesSummaryUseCase = Get.find<GetAccountGamesSummaryUseCase>();
    final userId = Get.find<CustomerDTO>().id;
    final response = await getAccountGamesSummaryUseCase(userId.toString());
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });
  static final bonusSummaryProvider = StateNotifierProvider.autoDispose<CardBonusSummaryProvider, CardsState>(
    (ref) => CardBonusSummaryProvider(
      Get.find<GetBonusSummaryUseCase>(),
    ),
  );
  static final accountGamesSummaryProvider = StateNotifierProvider.autoDispose<AccountGamesSummaryProvider, CardsState>(
    (ref) => AccountGamesSummaryProvider(
      Get.find<GetAccountGamesSummaryUseCase>(),
    ),
  );
  static final transferBalance =
      FutureProvider.autoDispose.family<String, TransferBalance>((ref, transferRequest) async {
    final TransferBalanceUseCase transferBalanceUseCase = Get.find<TransferBalanceUseCase>();
    final response = await transferBalanceUseCase(transferRequest);
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });
  static final lostCardProvider = FutureProvider.autoDispose.family<void, CardDetails>((ref, cardDetails) async {
    final LostCardUseCase lostCardUseCase = Get.find<LostCardUseCase>();
    final response = await lostCardUseCase({
      "SourceAccountDTO": {
        "AccountId": cardDetails.accountId,
        "TagNumber": cardDetails.accountNumber,
      }
    });
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });
  static final membershipCardProvider = Provider.autoDispose<CardDetails>(
    (ref) {
      final cardNumber = ref.watch(membershipInfoProvider).value?.membershipCard;
      final cards = ref.watch(userCardsProvider).value;
      return cards!.firstWhere((element) => element.accountNumber == cardNumber);
    },
  );
}

class CardBonusSummaryProvider extends StateNotifier<CardsState> {
  final GetBonusSummaryUseCase _getBonusSummary;

  CardBonusSummaryProvider(this._getBonusSummary) : super(const _InProgress());
  List<AccountCreditPlusDTOList> _list = [];
  void getSummary(String accountNumber) async {
    final response = await _getBonusSummary(accountNumber);
    response.fold(
      (l) => state = _Error(l.message),
      (r) {
        _list = r;
        state = _Success(_list);
      },
    );
  }

  void filter(DateTime filter) async {
    state = const _InProgress();
    final filteredList = _list.where((element) => element.periodTo?.isBefore(filter) ?? false).toList();
    state = _Success(filteredList);
  }
}

class AccountGamesSummaryProvider extends StateNotifier<CardsState> {
  final GetAccountGamesSummaryUseCase _getAccountGamesSummary;

  AccountGamesSummaryProvider(this._getAccountGamesSummary) : super(const _InProgress());
  List<AccountGameDTOList> _list = [];
  void getSummary(String accountNumber) async {
    final response = await _getAccountGamesSummary(accountNumber);
    response.fold(
      (l) => state = _Error(l.message),
      (r) {
        _list = r;
        state = _AccountGamesSuccess(_list);
      },
    );
  }

  void filter(DateTime filter) async {
    state = const _InProgress();
    final filteredList = _list.where((element) => element.fromDate?.isBefore(filter) ?? false).toList();
    state = _AccountGamesSuccess(filteredList);
  }
}
