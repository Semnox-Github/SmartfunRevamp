// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetails _$OrderDetailsFromJson(Map<String, dynamic> json) => OrderDetails(
      json['TransactionId'] as int,
      json['TransactionAmount'] as num,
      json['TransactionDiscountAmount'] as num,
      json['TaxAmount'] as num,
      json['TransactionNetAmount'] as num,
      json['TransactionOTP'] as String,
      json['TransactionDate'] == null
          ? null
          : DateTime.parse(json['TransactionDate'] as String),
      json['ReceiptHTML'] as String?,
      json['Receipt'] as String?,
      json['Status'] as String?,
      (json['TransactionLinesDTOList'] as List<dynamic>?)
          ?.map((e) =>
              TransactionLinesDTOList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDetailsToJson(OrderDetails instance) {
  final val = <String, dynamic>{
    'TransactionId': instance.transactionId,
    'TransactionAmount': instance.transactionAmount,
    'TransactionDiscountAmount': instance.transactionDiscountAmount,
    'TaxAmount': instance.taxAmount,
    'TransactionNetAmount': instance.transactionNetAmount,
    'TransactionOTP': instance.transactionOTP,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ReceiptHTML', instance.receiptHTML);
  writeNotNull('Receipt', instance.receipt);
  writeNotNull('Status', instance.status);
  writeNotNull('TransactionDate', instance.transactionDate?.toIso8601String());
  writeNotNull('TransactionLinesDTOList', instance.transactionLinesDTOList);
  return val;
}

TransactionLinesDTOList _$TransactionLinesDTOListFromJson(
        Map<String, dynamic> json) =>
    TransactionLinesDTOList(
      json['TransactionId'] as int,
      json['CardNumber'] as String?,
      json['ProductName'] as String?,
    );

Map<String, dynamic> _$TransactionLinesDTOListToJson(
    TransactionLinesDTOList instance) {
  final val = <String, dynamic>{
    'TransactionId': instance.transactionId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CardNumber', instance.cardNumber);
  writeNotNull('ProductName', instance.productName);
  return val;
}
