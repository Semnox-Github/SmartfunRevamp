// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_register_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationRegisterEntity _$NotificationRegisterEntityFromJson(
        Map<String, dynamic> json) =>
    NotificationRegisterEntity(
      json['Id'] as int,
      json['CustomerId'] as int,
      json['PushNotificationToken'] as String,
      json['DeviceType'] as String,
      isActive: json['IsActive'] as bool? ?? true,
      customerSignedIn: json['CustomerSignedIn'] as bool? ?? true,
    );

Map<String, dynamic> _$NotificationRegisterEntityToJson(
        NotificationRegisterEntity instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'CustomerId': instance.customerId,
      'PushNotificationToken': instance.pushNotificationToken,
      'DeviceType': instance.deviceType,
      'IsActive': instance.isActive,
      'CustomerSignedIn': instance.customerSignedIn,
    };
