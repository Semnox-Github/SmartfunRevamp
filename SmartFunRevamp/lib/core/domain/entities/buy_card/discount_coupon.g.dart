// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountCountResponse _$DiscountCountResponseFromJson(
        Map<String, dynamic> json) =>
    DiscountCountResponse(
      json['TransactionId'] as int,
      json['ApprovedBy'] as int,
      (json['TransactionAmount'] as num).toDouble(),
      (json['TransactionNetAmount'] as num).toDouble(),
      json['PrimaryCardId'] as int,
      (json['TransactionDiscountTotal'] as num).toDouble(),
      (json['TransactionDiscountDTOList'] as List<dynamic>)
          .map((e) =>
              TransactionDiscountDTOList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DiscountCountResponseToJson(
        DiscountCountResponse instance) =>
    <String, dynamic>{
      'TransactionId': instance.transactionId,
      'ApprovedBy': instance.approvedBy,
      'TransactionAmount': instance.transactionAmount,
      'TransactionNetAmount': instance.transactionNetAmount,
      'PrimaryCardId': instance.primaryCardId,
      'TransactionDiscountTotal': instance.transactionDiscountTotal,
      'TransactionDiscountDTOList': instance.transactionDiscountDTOList,
    };

TransactionDiscountDTOList _$TransactionDiscountDTOListFromJson(
        Map<String, dynamic> json) =>
    TransactionDiscountDTOList(
      (json['TaxAmount'] as num).toDouble(),
      json['DiscountAmount'] as int,
      json['CouponNumber'] as String,
    );

Map<String, dynamic> _$TransactionDiscountDTOListToJson(
        TransactionDiscountDTOList instance) =>
    <String, dynamic>{
      'TaxAmount': instance.taxAmount,
      'DiscountAmount': instance.discountAmount,
      'CouponNumber': instance.couponNumber,
    };
