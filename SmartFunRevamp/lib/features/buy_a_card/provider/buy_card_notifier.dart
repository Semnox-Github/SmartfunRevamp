import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/domain/use_cases/products/estimate_transaction_use_case.dart';
import 'package:semnox/core/domain/use_cases/products/get_products_price_use_case.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

part 'buy_card_state.dart';
part 'buy_card_notifier.freezed.dart';

final buyCardNotifier = StateNotifierProvider<BuyCardNotifier, BuyCardState>(
  (ref) => BuyCardNotifier(
    Get.find<GetProductsPriceUseCase>(),
  ),
);
final estimateProvider = FutureProvider.family<EstimateTransactionResponse, CardProduct>((ref, card) async {
  final EstimateTransactionUseCase estimateTransactionUseCase = Get.find<EstimateTransactionUseCase>();
  final customer = Get.find<CustomerDTO>();
  final response = await estimateTransactionUseCase(
    EstimateTransactionRequest(
      siteId: customer.siteId!,
      customerId: customer.id!,
      userName: customer.userName!,
      commitTransaction: false,
      transactionLinesDTOList: [
        TransactionLinesDTO(productId: card.productId!),
      ],
    ).toJson(),
  );
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});

class BuyCardNotifier extends StateNotifier<BuyCardState> {
  final GetProductsPriceUseCase _getProductsPriceUseCase;

  List<CardProduct> _cards = [];

  BuyCardNotifier(this._getProductsPriceUseCase) : super(const _InProgress()) {
    _getCards();
  }

  void _getCards() async {
    final response = await _getProductsPriceUseCase();
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
    // 1<x<2
    final filteredList = _cards
        .where(
          (element) => orderList.first <= element.finalPrice && element.finalPrice <= orderList.last,
        )
        .toList();
    state = _Success(filteredList);
  }
}
