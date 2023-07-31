// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_tier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipContainerResponse _$MembershipContainerResponseFromJson(
        Map<String, dynamic> json) =>
    MembershipContainerResponse(
      (json['MembershipContainerDTOList'] as List<dynamic>)
          .map((e) => MembershipTier.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MembershipContainerResponseToJson(
        MembershipContainerResponse instance) =>
    <String, dynamic>{
      'MembershipContainerDTOList':
          instance.membershipContainerDTOList.map((e) => e.toJson()).toList(),
    };

MembershipTier _$MembershipTierFromJson(Map<String, dynamic> json) =>
    MembershipTier(
      json['MembershipId'] as int,
      json['MembershipName'] as String,
      json['Description'] as String,
      json['VIP'] as bool,
      (json['NextMembershipIdList'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$MembershipTierToJson(MembershipTier instance) =>
    <String, dynamic>{
      'MembershipId': instance.membershipId,
      'MembershipName': instance.membershipName,
      'Description': instance.description,
      'VIP': instance.isVip,
      'NextMembershipIdList': instance.nextMembershipIdList,
    };
