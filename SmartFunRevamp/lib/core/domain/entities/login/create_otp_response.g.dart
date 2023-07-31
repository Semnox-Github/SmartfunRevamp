// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOtpResponse _$CreateOtpResponseFromJson(Map<String, dynamic> json) =>
    CreateOtpResponse(
      json['Id'] as int,
      json['Code'] as String,
      json['Phone'] as String?,
      json['CountryCode'] as String?,
      json['EmailId'] as String?,
      json['Source'] as String,
      json['IsVerified'] as bool,
      json['RemainingAttempts'] as int,
      DateTime.parse(json['ExpiryTime'] as String),
      json['Guid'] as String,
      json['IsActive'] as bool,
      json['SiteId'] as int,
      json['SynchStatus'] as bool,
      json['MasterEntityId'] as int,
    );

Map<String, dynamic> _$CreateOtpResponseToJson(CreateOtpResponse instance) {
  final val = <String, dynamic>{
    'Id': instance.id,
    'Code': instance.code,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Phone', instance.phone);
  writeNotNull('CountryCode', instance.countryCode);
  writeNotNull('EmailId', instance.emailId);
  val['Source'] = instance.source;
  val['IsVerified'] = instance.isVerified;
  val['RemainingAttempts'] = instance.remainingAttempts;
  val['ExpiryTime'] = instance.expiryTime.toIso8601String();
  val['Guid'] = instance.guid;
  val['IsActive'] = instance.isActive;
  val['SiteId'] = instance.siteId;
  val['SynchStatus'] = instance.synchStatus;
  val['MasterEntityId'] = instance.masterEntityId;
  return val;
}
