// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatus _$OrderStatusFromJson(Map<String, dynamic> json) => OrderStatus(
      json['TransactionId'] as int,
      json['TransactionStatus'] as String,
      json['PaymentStatus'] as String?,
      json['Message'] as String?,
    );

Map<String, dynamic> _$OrderStatusToJson(OrderStatus instance) {
  final val = <String, dynamic>{
    'TransactionId': instance.transactionId,
    'TransactionStatus': instance.transactionStatus,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PaymentStatus', instance.paymentStatus);
  writeNotNull('Message', instance.message);
  return val;
}
