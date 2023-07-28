// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountApplicationHistoryDTOList _$DiscountApplicationHistoryDTOListFromJson(
        Map<String, dynamic> json) =>
    DiscountApplicationHistoryDTOList(
      json['DiscountId'] as int,
      json['CouponNumber'] as String,
      json['ApprovedBy'] as int,
    );

Map<String, dynamic> _$DiscountApplicationHistoryDTOListToJson(
        DiscountApplicationHistoryDTOList instance) =>
    <String, dynamic>{
      'DiscountId': instance.discountId,
      'CouponNumber': instance.couponNumber,
      'ApprovedBy': instance.approvedBy,
    };
