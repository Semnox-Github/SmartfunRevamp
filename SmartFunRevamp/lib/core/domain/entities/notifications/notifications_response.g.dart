// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsResponse _$NotificationsResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationsResponse(
      DateTime.parse(json['SendDate'] as String),
      json['Subject'] as String,
      json['Body'] as String,
      json['IsUnread'] as bool,
    );

Map<String, dynamic> _$NotificationsResponseToJson(
        NotificationsResponse instance) =>
    <String, dynamic>{
      'SendDate': instance.sendDate.toIso8601String(),
      'Subject': instance.subject,
      'Body': instance.body,
      'IsUnread': instance.isUnread,
    };
