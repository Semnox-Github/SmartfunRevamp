import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/discount_entity.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/domain/use_cases/products/estimate_transaction_use_case.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

part 'estimate_state.dart';
part 'estimate_provider.freezed.dart';

// final estimateCouponProvider = FutureProvider.family<EstimateTransactionResponse, String>((ref, coupon) async {
//   final EstimateTransactionUseCase estimateTransactionUseCase = Get.find<EstimateTransactionUseCase>();
//   final customer = Get.find<CustomerDTO>();
//   final discountCoupon = DiscountApplicationHistoryDTOList(-1, coupon, -1);
//   final card = ref.read(estimateStateProvider.notifier).cardProduct;
//   final response = await estimateTransactionUseCase(
//     EstimateTransactionRequest(
//       siteId: customer.siteId!,
//       customerId: customer.id!,
//       userName: customer.userName!,
//       commitTransaction: false,
//       discountApplicationHistoryDTOList: [discountCoupon],
//       transactionLinesDTOList: [
//         TransactionLinesDTO(productId: card.productId!),
//       ],
//     ).toJson(),
//   );
//   return response.fold(
//     (l) => throw l,
//     (r) => r,
//   );
// });

final estimateStateProvider = StateNotifierProvider.autoDispose<EstimateStateProvider, EstimateState>(
  (ref) => EstimateStateProvider(
    Get.find<EstimateTransactionUseCase>(),
    Get.find<CustomerDTO>(),
  ),
);

final estimateCouponProvider = StateNotifierProvider.autoDispose<EstimateStateProvider, EstimateState>(
  (ref) => EstimateStateProvider(
    Get.find<EstimateTransactionUseCase>(),
    Get.find<CustomerDTO>(),
  ),
);

class EstimateStateProvider extends StateNotifier<EstimateState> {
  EstimateStateProvider(this._estimateTransactionUseCase, this._customer) : super(const _InProgress());
  final EstimateTransactionUseCase _estimateTransactionUseCase;
  final CustomerDTO _customer;
  late EstimateTransactionResponse _estimateTransactionResponse;

  void resetCoupon() {
    state = const _InProgress();
    _estimateTransactionResponse.couponDiscountAmount = null;
    _estimateTransactionResponse.couponNumber = null;
    state = _TransactionEstimated(_estimateTransactionResponse);
  }

  void getEstimateTransaction(CardProduct card, {DiscountApplicationHistoryDTOList? dtoList}) async {
    final response = await _estimateTransactionUseCase(
      EstimateTransactionRequest(
        siteId: _customer.siteId!,
        customerId: _customer.id!,
        userName: _customer.userName!,
        commitTransaction: false,
        transactionLinesDTOList: [
          TransactionLinesDTO(productId: card.productId!),
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
