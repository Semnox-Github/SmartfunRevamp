// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticate_system_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemUser _$SystemUserFromJson(Map<String, dynamic> json) => SystemUser(
      json['PosMachineGuid'] as String,
      json['WebApiToken'] as String?,
      json['Token'] as String?,
      json['LanguageId'] as int,
      json['IsCorporate'] as bool,
      json['UserPKId'] as int,
      json['MachineId'] as int,
      json['SiteId'] as int,
      json['SitePKId'] as int,
      json['UserId'] as String,
      json['POSMachineName'] as String,
      json['LanguageCode'] as String,
    );

Map<String, dynamic> _$SystemUserToJson(SystemUser instance) {
  final val = <String, dynamic>{
    'PosMachineGuid': instance.posMachineGuid,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('WebApiToken', instance.webApiToken);
  writeNotNull('Token', instance.token);
  val['LanguageId'] = instance.languageId;
  val['IsCorporate'] = instance.isCorporate;
  val['UserPKId'] = instance.userPKId;
  val['MachineId'] = instance.machineId;
  val['SiteId'] = instance.siteId;
  val['SitePKId'] = instance.sitePKId;
  val['UserId'] = instance.userId;
  val['POSMachineName'] = instance.pOSMachineName;
  val['LanguageCode'] = instance.languageCode;
  return val;
}
