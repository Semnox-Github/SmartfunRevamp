part of 'orders_provider.dart';

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState.initial() = _Initial;
  const factory OrdersState.inProgress() = _InProgress;
  const factory OrdersState.success(List<OrderDetails> ordersSummary) = _Success;
  const factory OrdersState.successOrderDetail(OrderDetails ordersSummaryDetails) = _SuccessOrderDetail;
  const factory OrdersState.orderDetailInProgress() = _OrderDetailInProgress;
  const factory OrdersState.error(String msg) = _Error;
}