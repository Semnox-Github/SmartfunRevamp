import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/card_details/bonus_summary.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/use_cases/cards/get_bonus_summary_use_case.dart';
import 'package:semnox/core/domain/use_cases/cards/get_card_details_use_case.dart';

import 'package:semnox/core/domain/use_cases/home/get_user_cards_use_case.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
part 'cards_state.dart';
part 'cards_provider.freezed.dart';

class CardsProviders {
  static final userCardsProvider = FutureProvider<List<CardDetails>>((ref) async {
    final GetUserCardsUseCase getUserCardsUseCase = Get.find<GetUserCardsUseCase>();
    final userId = Get.find<CustomerDTO>().id;
    final response = await getUserCardsUseCase(userId.toString());
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
}

final cardsDetailsProvider = FutureProvider.family<CardDetails, String>((ref, accountNumber) async {
  final GetCardDetailsUseCase getDetails = Get.find<GetCardDetailsUseCase>();
  final response = await getDetails(accountNumber);
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});

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
