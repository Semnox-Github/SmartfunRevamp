part of 'estimate_provider.dart';

@freezed
class EstimateState with _$EstimateState {
  const factory EstimateState.inProgress() = _InProgress;
  const factory EstimateState.error(String message) = _Error;
  const factory EstimateState.invalidCoupon(String message) = _InvalidCoupon;
  const factory EstimateState.transactionEstimated(EstimateTransactionResponse response) = _TransactionEstimated;
}
