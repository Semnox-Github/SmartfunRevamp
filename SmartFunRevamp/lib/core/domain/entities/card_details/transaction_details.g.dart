// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDetail _$TransactionDetailFromJson(Map<String, dynamic> json) =>
    TransactionDetail(
      json['TransactionId'] as int,
      json['TransactionOTP'] as String,
      json['TransactionDate'] == null
          ? null
          : DateTime.parse(json['TransactionDate'] as String),
      (json['TransactionLineDTOList'] as List<dynamic>?)
          ?.map((e) => TransactionLineDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['TransactionTaxLineDTOList'] as List<dynamic>?)
          ?.map((e) =>
              TransactionTaxLineDTOList.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['Receipt'] as String?,
      json['Status'] as String?,
      (json['TransactionTaxTotal'] as num?)?.toDouble(),
      (json['TransactionNetAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TransactionDetailToJson(TransactionDetail instance) {
  final val = <String, dynamic>{
    'TransactionId': instance.transactionId,
    'TransactionOTP': instance.transactionOTP,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Receipt', instance.receipt);
  writeNotNull('Status', instance.status);
  writeNotNull('TransactionTaxTotal', instance.transactionTaxTotal);
  writeNotNull('TransactionNetAmount', instance.transactionNetAmount);
  writeNotNull('TransactionDate', instance.transactionDate?.toIso8601String());
  writeNotNull('TransactionLineDTOList', instance.transactionLineDTOList);
  writeNotNull('TransactionTaxLineDTOList', instance.transactionTaxLineDTOList);
  return val;
}

TransactionLineDTO _$TransactionLineDTOFromJson(Map<String, dynamic> json) =>
    TransactionLineDTO(
      json['TagNumber'] as String,
      json['ProductName'] as String,
    );

Map<String, dynamic> _$TransactionLineDTOToJson(TransactionLineDTO instance) =>
    <String, dynamic>{
      'TagNumber': instance.TagNumber,
      'ProductName': instance.ProductName,
    };

TransactionTaxLineDTOList _$TransactionTaxLineDTOListFromJson(
        Map<String, dynamic> json) =>
    TransactionTaxLineDTOList(
      (json['TaxAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$TransactionTaxLineDTOListToJson(
        TransactionTaxLineDTOList instance) =>
    <String, dynamic>{
      'TaxAmount': instance.TaxAmount,
    };
