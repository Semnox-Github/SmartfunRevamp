// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hosted_payment_gateway_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostedPaymentGatewayRequest _$HostedPaymentGatewayRequestFromJson(
        Map<String, dynamic> json) =>
    HostedPaymentGatewayRequest(
      hostedPaymentGateway: json['HostedPaymentGateway'] as String,
      amount: (json['Amount'] as num).toDouble(),
      transactionId: json['TransactionId'] as int,
    );

Map<String, dynamic> _$HostedPaymentGatewayRequestToJson(
        HostedPaymentGatewayRequest instance) =>
    <String, dynamic>{
      'HostedPaymentGateway': instance.hostedPaymentGateway,
      'Amount': instance.amount,
      'TransactionId': instance.transactionId,
    };
