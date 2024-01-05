// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderResponse _$CreateOrderResponseFromJson(Map<String, dynamic> json) =>
    CreateOrderResponse(
      json['OrderId'] as int,
      json['TableId'] as int,
      json['OrderDate'] as String,
      json['GuestName'] as String,
      json['GuestContactNumber'] as String,
      json['TransactionIdentifier'] as String,
      json['TentNumber'] as String,
      json['OrderStatus'] as String,
      json['OrderStatusId'] as int,
      json['OrderStatusChangeDate'] as String,
      json['TransactionId'] as int,
      json['TransactionNumber'] as String,
      (json['TransactionAmount'] as num).toDouble(),
      json['TransactionStatus'] as String,
      json['TransactionStatusId'] as int,
      json['PaymentStatus'] as String,
      json['PaymentStatusId'] as int,
      json['IsAccessible'] as bool,
    );

Map<String, dynamic> _$CreateOrderResponseToJson(
        CreateOrderResponse instance) =>
    <String, dynamic>{
      'OrderId': instance.orderId,
      'TableId': instance.tableId,
      'OrderDate': instance.orderDate,
      'GuestName': instance.guestName,
      'GuestContactNumber': instance.guestContactNumber,
      'TransactionIdentifier': instance.transactionIdentifier,
      'TentNumber': instance.tentNumber,
      'OrderStatus': instance.orderStatus,
      'OrderStatusId': instance.orderStatusId,
      'OrderStatusChangeDate': instance.orderStatusChangeDate,
      'TransactionId': instance.transactionId,
      'TransactionNumber': instance.transactionNumber,
      'TransactionAmount': instance.transactionAmount,
      'TransactionStatus': instance.transactionStatus,
      'TransactionStatusId': instance.transactionStatusId,
      'PaymentStatus': instance.paymentStatus,
      'PaymentStatusId': instance.paymentStatusId,
      'IsAccessible': instance.isAccessible,
    };
