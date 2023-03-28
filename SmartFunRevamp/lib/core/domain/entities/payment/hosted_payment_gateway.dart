import 'package:json_annotation/json_annotation.dart';
part 'hosted_payment_gateway.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class HostedPaymentGateway {
  final String successURL;
  final String callBackURL;
  final String failureURL;
  final String cancelURL;
  final String gatewayRequestString;
  final String? gatewayRequestFormString;
  

  HostedPaymentGateway(this.successURL, this.callBackURL, this.failureURL, this.cancelURL, this.gatewayRequestString, this.gatewayRequestFormString);
  factory HostedPaymentGateway.fromJson(Map<String, dynamic> json) => _$HostedPaymentGatewayFromJson(json);
  Map<String, dynamic> toJson() => _$HostedPaymentGatewayToJson(this);
}
