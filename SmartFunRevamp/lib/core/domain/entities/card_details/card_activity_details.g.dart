// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_activity_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardActivityDetails _$CardActivityDetailsFromJson(Map<String, dynamic> json) =>
    CardActivityDetails(
      json['TransactionId'] as int,
      json['TransactionOTP'] as String,
      json['TransactionDate'] == null
          ? null
          : DateTime.parse(json['TransactionDate'] as String),
      (json['TransactionLinesDTOList'] as List<dynamic>?)
          ?.map((e) => TransactionLinesDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['TrxPaymentDTOList'] as List<dynamic>?)
          ?.map((e) => TrxPaymentsDTOList.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['ReceiptHTML'] as String?,
      json['Receipt'] as String?,
      json['Status'] as String?,
    );

Map<String, dynamic> _$CardActivityDetailsToJson(CardActivityDetails instance) {
  final val = <String, dynamic>{
    'TransactionId': instance.transactionId,
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
  writeNotNull('TrxPaymentDTOList', instance.trxPaymentDTOList);
  return val;
}

TrxPaymentsDTOList _$TrxPaymentsDTOListFromJson(Map<String, dynamic> json) =>
    TrxPaymentsDTOList(
      json['Amount'] as num,
    );

Map<String, dynamic> _$TrxPaymentsDTOListToJson(TrxPaymentsDTOList instance) =>
    <String, dynamic>{
      'Amount': instance.amount,
    };
