import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/orders/order_details.dart';
import 'package:semnox/core/domain/entities/orders/order_status.dart';
import 'package:semnox/core/domain/use_cases/orders/get_customer_transaction_status_use_case.dart';
import 'package:semnox/core/domain/use_cases/orders/get_customer_transactions_use_case.dart';
import 'package:semnox/core/domain/use_cases/orders/get_transaction_detail_use_case.dart';

import '../../../core/domain/entities/card_details/transaction_details.dart';
part 'orders_state.dart';
part 'orders_provider.freezed.dart';

class OrdersProviders {
  static final ordersSummaryProvider = StateNotifierProvider.autoDispose<OrdersSummaryProvider, OrdersState>(
    (ref) => OrdersSummaryProvider(
      Get.find<GetCustomerTransactionsUseCase>(),
    ),
  );

  static final orderSummaryDetailProvider = StateNotifierProvider.autoDispose<OrderSummaryDetailProvider, OrdersState>(
    (ref) => OrderSummaryDetailProvider(
      Get.find<GetTransactionDetailUseCase>(),
    ),
  );

  static final orderSummaryDetailProviderResponse =
      FutureProvider.autoDispose.family<OrderDetails, String>((ref, transactionId) async {
    final GetTransactionDetailUseCase getTransactionDetailUseCase = Get.find<GetTransactionDetailUseCase>();
    final response = await getTransactionDetailUseCase(transactionId);
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });

  static final customerOrderStatusProvider =
      StateNotifierProvider.autoDispose<CustomerOrderStatusProvider, OrdersState>(
    (ref) => CustomerOrderStatusProvider(
      Get.find<GetCustomerTransactionStatusUseCase>(),
    ),
  );

  static final customerOrderStatusProviderResponse =
      FutureProvider.autoDispose.family<List<OrderStatus>, String>((ref, customerId) async {
    final GetCustomerTransactionStatusUseCase getCustomerTransactionStatusUseCase =
        Get.find<GetCustomerTransactionStatusUseCase>();
    final response = await getCustomerTransactionStatusUseCase(customerId);
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });
}

class OrdersSummaryProvider extends StateNotifier<OrdersState> {
  final GetCustomerTransactionsUseCase _getCustomerTransactionsUseCase;

  OrdersSummaryProvider(this._getCustomerTransactionsUseCase) : super(const _InProgress());
  List<TransactionDetail> _list = [];
  void getSummary(String customerId) async {
    final response = await _getCustomerTransactionsUseCase(customerId);
    response.fold(
      (l) => state = _Error(l.message),
      (r) {
        _list = r;
        state = _Success(_list);
      },
    );
  }
}

class OrderSummaryDetailProvider extends StateNotifier<OrdersState> {
  final GetTransactionDetailUseCase _getTransactionDetailUseCase;

  OrderSummaryDetailProvider(this._getTransactionDetailUseCase) : super(const _OrderDetailInProgress());
  late OrderDetails _cardActivityDetails;
  void getDetail(String transactionId) async {
    final response = await _getTransactionDetailUseCase(transactionId);
    response.fold(
      (l) => state = _Error(l.message),
      (r) {
        _cardActivityDetails = r;
        state = _SuccessOrderDetail(_cardActivityDetails);
      },
    );
  }
}

class CustomerOrderStatusProvider extends StateNotifier<OrdersState> {
  final GetCustomerTransactionStatusUseCase _getCustomerTransactionStatusUseCase;

  CustomerOrderStatusProvider(this._getCustomerTransactionStatusUseCase) : super(const _InProgress());
  List<OrderStatus> _list = [];
  void getCustomerOderStatus(String customerId) async {
    final response = await _getCustomerTransactionStatusUseCase(customerId);
    response.fold(
      (l) => state = _Error(l.message),
      (r) {
        _list = r;
        state = _SuccessCustomerOrderStatus(_list);
      },
    );
  }
}
