// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipInfo _$MembershipInfoFromJson(Map<String, dynamic> json) =>
    MembershipInfo(
      json['MembershipId'] as int?,
      (json['MembershipTotalPoints'] as num?)?.toDouble(),
      json['MemberShipName'] as String?,
      json['MembershipValidity'] == null
          ? null
          : DateTime.parse(json['MembershipValidity'] as String),
      json['MembershipCard'] as String?,
    );

Map<String, dynamic> _$MembershipInfoToJson(MembershipInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('MembershipId', instance.membershipId);
  writeNotNull('MembershipTotalPoints', instance.membershipTotalPoints);
  writeNotNull('MemberShipName', instance.memberShipName);
  writeNotNull(
      'MembershipValidity', instance.membershipValidity?.toIso8601String());
  writeNotNull('MembershipCard', instance.membershipCard);
  return val;
}
