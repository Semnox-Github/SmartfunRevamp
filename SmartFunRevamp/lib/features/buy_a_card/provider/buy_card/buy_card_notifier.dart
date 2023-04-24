import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/domain/use_cases/products/get_products_price_use_case.dart';

part 'buy_card_state.dart';
part 'buy_card_notifier.freezed.dart';

final buyCardNotifier = StateNotifierProvider.autoDispose<BuyCardNotifier, BuyCardState>(
  (ref) => BuyCardNotifier(
    Get.find<GetProductsPriceUseCase>(),
  ),
);

class BuyCardNotifier extends StateNotifier<BuyCardState> {
  final GetProductsPriceUseCase _getProductsPriceUseCase;

  List<CardProduct> _cards = [];

  BuyCardNotifier(this._getProductsPriceUseCase) : super(const _InProgress());

  void getCards(int siteId) async {
    state = const _InProgress();
    final response = await _getProductsPriceUseCase(siteId);
    response.fold(
      (l) => state = _Error(l.message),
      (r) {
        _cards = r;
        state = _Success(_cards);
      },
    );
  }

  void filter(List<List<int>> filters) async {
    state = const _InProgress();
    List<int> orderList = [];
    filters.map((e) {
      orderList.addAll(e);
    }).toList();
    orderList.sort();
    final filteredList = _cards
        .where(
          (element) => orderList.first <= element.finalPrice && element.finalPrice <= orderList.last,
        )
        .toList();
    state = _Success(filteredList);
  }
}
