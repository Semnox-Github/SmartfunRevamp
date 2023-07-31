// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parafait_defaults_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParafaitDefaultsResponse _$ParafaitDefaultsResponseFromJson(
        Map<String, dynamic> json) =>
    ParafaitDefaultsResponse(
      (json['ParafaitDefaultContainerDTOList'] as List<dynamic>)
          .map((e) => ParafaitDefault.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ParafaitDefaultsResponseToJson(
        ParafaitDefaultsResponse instance) =>
    <String, dynamic>{
      'ParafaitDefaultContainerDTOList':
          instance.parafaitsDefaults.map((e) => e.toJson()).toList(),
    };

ParafaitDefault _$ParafaitDefaultFromJson(Map<String, dynamic> json) =>
    ParafaitDefault(
      json['DefaultValueName'] as String,
      json['DefaultValue'] as String,
    );

Map<String, dynamic> _$ParafaitDefaultToJson(ParafaitDefault instance) =>
    <String, dynamic>{
      'DefaultValueName': instance.defaultValueName,
      'DefaultValue': instance.defaultValue,
    };
