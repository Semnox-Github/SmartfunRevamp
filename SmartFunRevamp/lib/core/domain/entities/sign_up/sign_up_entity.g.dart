// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpEntity _$SignUpEntityFromJson(Map<String, dynamic> json) => SignUpEntity(
      id: json['id'] as int?,
      profileId: json['profile_id'] as int?,
      masterEntityId: json['master_entity_id'] as int?,
      membershipId: json['membership_id'] as int?,
      profileDto: json['profile_dto'] == null
          ? null
          : ProfileDTO.fromJson(json['profile_dto'] as Map<String, dynamic>),
      customDataSetDto: json['custom_data_set_dto'] == null
          ? null
          : CustomDataSetDTO.fromJson(
              json['custom_data_set_dto'] as Map<String, dynamic>),
      creationDate: json['creation_date'] as String?,
      lastUpdateDate: json['last_update_date'] as String?,
      siteId: json['site_id'] as int?,
      guid: json['guid'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$SignUpEntityToJson(SignUpEntity instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('profile_id', instance.profileId);
  writeNotNull('master_entity_id', instance.masterEntityId);
  writeNotNull('membership_id', instance.membershipId);
  writeNotNull('custom_data_set_dto', instance.customDataSetDto);
  writeNotNull('creation_date', instance.creationDate);
  writeNotNull('last_update_date', instance.lastUpdateDate);
  writeNotNull('site_id', instance.siteId);
  writeNotNull('guid', instance.guid);
  writeNotNull('phone', instance.phone);
  writeNotNull('email', instance.email);
  writeNotNull('profile_dto', instance.profileDto);
  return val;
}
