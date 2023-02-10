import 'package:json_annotation/json_annotation.dart';
part 'hosted_payment_gateway_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class HostedPaymentGatewayRequest {
  final String hostedPaymentGateway;
  final double amount;
  final int transactionId;
  

  HostedPaymentGatewayRequest({required this.hostedPaymentGateway, required this.amount, required this.transactionId});
  factory HostedPaymentGatewayRequest.fromJson(Map<String, dynamic> json) => _$HostedPaymentGatewayRequestFromJson(json);
  Map<String, dynamic> toJson() => _$HostedPaymentGatewayRequestToJson(this);
}


 