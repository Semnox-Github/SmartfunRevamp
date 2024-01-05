// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lookups_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookupsContainer _$LookupsContainerFromJson(Map<String, dynamic> json) =>
    LookupsContainer(
      (json['LookupsContainerDTOList'] as List<dynamic>)
          .map((e) =>
              LookupsContainerDTOList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LookupsContainerToJson(LookupsContainer instance) =>
    <String, dynamic>{
      'LookupsContainerDTOList': instance.lookupsContainerDTOList,
    };

LookupsContainerDTOList _$LookupsContainerDTOListFromJson(
        Map<String, dynamic> json) =>
    LookupsContainerDTOList(
      json['LookupId'] as int,
      json['LookupName'] as String,
      json['IsProtected'] as String,
      (json['LookupValuesContainerDTOList'] as List<dynamic>)
          .map((e) =>
              LookupValuesContainerDTOList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LookupsContainerDTOListToJson(
        LookupsContainerDTOList instance) =>
    <String, dynamic>{
      'LookupId': instance.lookupId,
      'LookupName': instance.lookupName,
      'IsProtected': instance.isProtected,
      'LookupValuesContainerDTOList': instance.lookupValuesContainerDTOList,
    };

LookupValuesContainerDTOList _$LookupValuesContainerDTOListFromJson(
        Map<String, dynamic> json) =>
    LookupValuesContainerDTOList(
      json['LookupValueId'] as int?,
      json['LookupValue'] as String?,
      json['Description'] as String?,
      json['LookupName'] as String?,
    );

Map<String, dynamic> _$LookupValuesContainerDTOListToJson(
    LookupValuesContainerDTOList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('LookupValueId', instance.lookupValueId);
  writeNotNull('LookupValue', instance.lookupValue);
  writeNotNull('Description', instance.description);
  writeNotNull('LookupName', instance.lookupName);
  return val;
}
