part of 'buy_card_notifier.dart';

@freezed
class BuyCardState with _$BuyCardState {
  const factory BuyCardState.inProgress() = _InProgress;
  const factory BuyCardState.success(List<CardProduct> cards) = _Success;
  const factory BuyCardState.error(String message) = _Error;
  const factory BuyCardState.estimatingTransaction() = _EstimatingTransaction;
  const factory BuyCardState.transactionEstimated(EstimateTransactionResponse response) = _TransactionEstimated;
  const factory BuyCardState.estimationError(String msg) = _EstimationError;
}
