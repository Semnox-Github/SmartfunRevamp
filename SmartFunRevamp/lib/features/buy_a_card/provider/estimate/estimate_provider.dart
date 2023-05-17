import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/discount_entity.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/domain/use_cases/products/estimate_transaction_use_case.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

part 'estimate_state.dart';
part 'estimate_provider.freezed.dart';

final estimateStateProvider = StateNotifierProvider.autoDispose<EstimateStateProvider, EstimateState>(
  (ref) => EstimateStateProvider(
    Get.find<EstimateTransactionUseCase>(),
    Get.find<CustomerDTO>(),
    Get.find<ExecutionContextDTO>(),
  ),
);

final estimateCouponProvider = StateNotifierProvider.autoDispose<EstimateStateProvider, EstimateState>(
  (ref) => EstimateStateProvider(
    Get.find<EstimateTransactionUseCase>(),
    Get.find<CustomerDTO>(),
    Get.find<ExecutionContextDTO>(),
  ),
);

class EstimateStateProvider extends StateNotifier<EstimateState> {
  EstimateStateProvider(this._estimateTransactionUseCase, this._customer, this._executionContextDTO) : super(const _InProgress());
  final EstimateTransactionUseCase _estimateTransactionUseCase;
  final CustomerDTO _customer;
  final ExecutionContextDTO _executionContextDTO;
  late EstimateTransactionResponse _estimateTransactionResponse;

  void resetCoupon() {
    state = const _InProgress();
    _estimateTransactionResponse.couponDiscountAmount = null;
    _estimateTransactionResponse.couponNumber = null;
    state = _TransactionEstimated(_estimateTransactionResponse);
  }

  void getEstimateTransaction(CardProduct card, {DiscountApplicationHistoryDTOList? dtoList, String? cardNumber, int quantity = 1}) async {
    late int siteId = _executionContextDTO.siteId?.toInt() ?? 1040;
    siteId = siteId == 1010 ? 1040 : siteId;
    final response = await _estimateTransactionUseCase(
      EstimateTransactionRequest(
        siteId: siteId,
        customerId: _customer.id!,
        userName: "CustomerApp",
        customerName: _customer.userName!,
        commitTransaction: true,
        transactionLinesDTOList: [
          TransactionLinesDTO(
            productId: card.productId!,
            cardNumber: cardNumber ?? '',
            quantity: quantity,
          ),
        ],
        discountApplicationHistoryDTOList: [if (dtoList != null) dtoList],
      ).toJson(),
    );
    response.fold(
      (l) {
        if (l is InvalidCouponFailure) {
          state = _InvalidCoupon(l.message);
          // _estimateTransactionResponse.couponDiscountAmount = 10.0;
          // _estimateTransactionResponse.couponNumber = 'AAAAAAA';
          state = _TransactionEstimated(_estimateTransactionResponse);
        } else {
          state = _Error(l.message);
        }
      },
      (r) {
        _estimateTransactionResponse = r;
        state = _TransactionEstimated(r);
      },
    );
  }
}
