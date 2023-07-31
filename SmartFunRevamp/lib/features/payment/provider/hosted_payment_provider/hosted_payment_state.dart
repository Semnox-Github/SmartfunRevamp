part of 'hosted_payment_provider.dart';

@freezed
class HostedPaymentState with _$HostedPaymentState {
  const factory HostedPaymentState.initial() = _Initial;
  const factory HostedPaymentState.inProgress() = _InProgress;
  const factory HostedPaymentState.success(HostedPaymentGateway hostedPaymentGateway) = _Success;
  const factory HostedPaymentState.error(String msg) = _Error;
}
