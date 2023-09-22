// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_base_url_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBaseUrlResponse _$GetBaseUrlResponseFromJson(Map<String, dynamic> json) =>
    GetBaseUrlResponse(
      json['AppId'] as String,
      json['ReleaseNumber'] as String,
      json['GateWayURL'] as String,
      json['Deprecated'] as String,
    );

Map<String, dynamic> _$GetBaseUrlResponseToJson(GetBaseUrlResponse instance) =>
    <String, dynamic>{
      'AppId': instance.appId,
      'ReleaseNumber': instance.releaseNumber,
      'GateWayURL': instance.gateWayURL,
      'Deprecated': instance.deprecated,
    };
