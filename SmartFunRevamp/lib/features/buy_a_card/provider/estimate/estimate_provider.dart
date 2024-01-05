import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/discount_entity.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/domain/use_cases/products/create_transaction_use_case.dart';
import 'package:semnox/core/domain/use_cases/products/estimate_transaction_use_case.dart';
import 'package:semnox/core/domain/use_cases/products/link_to_customer_use_case.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

import '../../../../core/data/datasources/local_data_source.dart';
import '../../../../core/domain/entities/buy_card/discount_coupon.dart';
import '../../../../core/domain/use_cases/products/add_card_product_use_case.dart';
import '../../../../core/domain/use_cases/products/create_order_use_case.dart';
import '../../../../core/domain/use_cases/products/discount_coupon_use_case.dart';
import '../../../../core/domain/use_cases/products/save_transaction_use_case.dart';

part 'estimate_state.dart';
part 'estimate_provider.freezed.dart';

final estimateStateProvider = StateNotifierProvider.autoDispose<EstimateStateProvider, EstimateState>(
  (ref) => EstimateStateProvider(
    Get.find<EstimateTransactionUseCase>(),
    Get.find<DiscountCouponUseCase>(),
    Get.find<CreateOrderUseCase>(),
    Get.find<CreateTransactionUseCase>(),
    Get.find<LinkToCustomerUseCase>(),
    Get.find<AddCardProductUseCase>(),
    Get.find<SaveTransactionUseCase>(),
    Get.find<CustomerDTO>(),
    Get.find<ExecutionContextDTO>(),
  ),
);

final estimateCouponProvider = StateNotifierProvider.autoDispose<EstimateStateProvider, EstimateState>(
  (ref) => EstimateStateProvider(
    Get.find<EstimateTransactionUseCase>(),
    Get.find<DiscountCouponUseCase>(),
    Get.find<CreateOrderUseCase>(),
    Get.find<CreateTransactionUseCase>(),
    Get.find<LinkToCustomerUseCase>(),
    Get.find<AddCardProductUseCase>(),
    Get.find<SaveTransactionUseCase>(),
    Get.find<CustomerDTO>(),
    Get.find<ExecutionContextDTO>(),
  ),
);

class EstimateStateProvider extends StateNotifier<EstimateState> {
  EstimateStateProvider(
    this._estimateTransactionUseCase,
    this._discountCouponUseCase,
    this._createOrderUseCase,
    this._createTransactionUseCase,
    this._linkToCustomerUseCase,
    this._addCardProductUseCase,
    this._saveTransactionUseCase,
    this._customer,
    this._executionContextDTO,
  ) : super(const _InProgress());
  final EstimateTransactionUseCase _estimateTransactionUseCase;
  final CreateOrderUseCase _createOrderUseCase;
  final CreateTransactionUseCase _createTransactionUseCase;
  final LinkToCustomerUseCase _linkToCustomerUseCase;
  final AddCardProductUseCase _addCardProductUseCase;
  final DiscountCouponUseCase _discountCouponUseCase;
  final SaveTransactionUseCase _saveTransactionUseCase;
  final CustomerDTO _customer;
  // ignore: unused_field
  final ExecutionContextDTO _executionContextDTO;
  late EstimateTransactionResponse _estimateTransactionResponse;
  late AddCardProductResponse _addCardProductResponse;
  late CardProduct _cardProduct;
  late String? _cardNumber;
  late int _quantity;
  late double _finalPrice;
  late String _transactionType;

  void resetCoupon() {
    state = const _InProgress();
    _addCardProductResponse.couponDiscountAmount = null;
    _addCardProductResponse.couponNumber = null;
    state = _TransactionEstimated(_addCardProductResponse);
  }

  void getProductInfo(CardProduct cardProduct, String? cardNumber,String transactionType,int quantity , double finalPrice){
    _cardProduct = cardProduct;
    _cardNumber = cardNumber;
    _quantity = quantity;
    _finalPrice = finalPrice;
    _transactionType = transactionType;
  }

  void createOrder()async{
    final response = await _createOrderUseCase(
        {
          "TableId": -1,
          "TableOperationDetails": {
            "Reason": "Create Order",
            "AdditionalComments": "",
            "ApprovalDTO": null
          },
        });
     response.fold((l) => null, (r) {
       createTransaction(r.data.orderId);
    });
  }

  void createTransaction(int orderId)async{

    DateTime currentTime = DateTime.now();

    final response = await _createTransactionUseCase(
        orderId,
        {
        "GuestCount": 2,
        "TransactionProfileId" : -1,
        "TransactionDateTime": _transactionType == "newcard" ? "" : currentTime.toString()
        });

    response.fold((l) => null, (r) {
      GluttonLocalDataSource()
          .saveValue(LocalDataSource.kTransactionId,r.data.transactionId);
      linkToCustomer(r.data.transactionId ?? -1);
    });
  }

  void linkToCustomer(int transactionId)async{
    final response = await _linkToCustomerUseCase(
        transactionId,
        _customer.id!);
      addCardProduct(transactionId);
  }


  void addCardProduct(
      int transactionId)async{
    final response = await _addCardProductUseCase(
        transactionId,
        [
          {
            "ProductId": _cardProduct.productId!,
            "Quantity": _quantity,
            "Amount": _finalPrice > 0 ? _finalPrice : 0,
            "TransactionAccountDTOList": [
              {
                "TagNumber": _cardNumber
              }
            ],
          },
        ]);
    response.fold(
            (l) {
              if (l is InvalidCouponFailure) {
                state = _InvalidCoupon(l.message);
                state = _TransactionEstimated(_addCardProductResponse);
              } else {
                state = _Error(l.message);
              }
            },
            (r) {
              _addCardProductResponse = r.data;
              state = _TransactionEstimated(r.data);
        });
  }

  void getEstimateTransaction(
      CardProduct card,
      {DiscountApplicationHistoryDTOList? dtoList,
      String? cardNumber,
      int quantity = 1,
      int? siteId,
      double finalPrice = 0}) async {
    final response = await _estimateTransactionUseCase(
      EstimateTransactionRequest(
        siteId: siteId ?? 1010,
        customerId: _customer.id!,
        userName: "CustomerApp",
        customerName: _customer.userName!,
        commitTransaction: true,
        transactionLinesDTOList: [
          TransactionLinesDTO(
            productId: card.productId!,
            cardNumber: cardNumber ?? '',
            quantity: quantity,
            amount: finalPrice > 0 ? finalPrice : null,
          ),
        ],
        discountApplicationHistoryDTOList: [if (dtoList != null) dtoList],
      ).toJson(),
    );
    response.fold(
      (l) {
        if (l is InvalidCouponFailure) {
          state = _InvalidCoupon(l.message);
          state = _TransactionEstimated(_addCardProductResponse);
        } else {
          state = _Error(l.message);
        }
      },
      (r) {
        // _estimateTransactionResponse = r;
        // state = _TransactionEstimated(r);
      },
    );
  }

  void addDiscountCoupon(
      int transactionId,
      CardProduct card,
      String coupon,
      {DiscountApplicationHistoryDTOList? dtoList,
        String? cardNumber,
        int quantity = 1,
        int? siteId,
        double finalPrice = 0})async{
    state = const _InProgress();
      final response = await _discountCouponUseCase(
        transactionId,
        {"CouponNumber": coupon});

      response.fold(
              (l) {
            if (l is InvalidCouponFailure) {
              state = _InvalidCoupon(l.message);
              state = _TransactionEstimated(_addCardProductResponse);
            } else {
              state = _Error(l.message);
            }
          },
          (r) {
            _addCardProductResponse = r.data;
            state = _TransactionEstimated(r.data);
          });
  }

   addSaveTransaction(
      int transactionId,
       AddCardProductResponse addCardProductResponse
       )async{
     state = const _InProgress();
    final response = await _saveTransactionUseCase(
        transactionId);

    response.fold(
            (l) {
            state = _Error(l.message);
        },
            (r) {
          state = _TransactionEstimated(addCardProductResponse);
        });
  }
}
