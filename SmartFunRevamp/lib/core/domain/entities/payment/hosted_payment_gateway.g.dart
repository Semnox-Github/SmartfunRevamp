// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hosted_payment_gateway.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostedPaymentGateway _$HostedPaymentGatewayFromJson(
        Map<String, dynamic> json) =>
    HostedPaymentGateway(
      json['SuccessURL'] as String?,
      json['CallBackURL'] as String?,
      json['FailureURL'] as String?,
      json['CancelURL'] as String?,
      json['GatewayRequestString'] as String,
      json['GatewayRequestFormString'] as String?,
    );

Map<String, dynamic> _$HostedPaymentGatewayToJson(
    HostedPaymentGateway instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SuccessURL', instance.successURL);
  writeNotNull('CallBackURL', instance.callBackURL);
  writeNotNull('FailureURL', instance.failureURL);
  writeNotNull('CancelURL', instance.cancelURL);
  val['GatewayRequestString'] = instance.gatewayRequestString;
  writeNotNull('GatewayRequestFormString', instance.gatewayRequestFormString);
  return val;
}
