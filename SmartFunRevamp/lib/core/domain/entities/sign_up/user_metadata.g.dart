// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMetaDataResponse _$UserMetaDataResponseFromJson(
        Map<String, dynamic> json) =>
    UserMetaDataResponse(
      (json['CustomerUIMetadataContainerDTOList'] as List<dynamic>)
          .map((e) => CustomerUIMetaData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserMetaDataResponseToJson(
        UserMetaDataResponse instance) =>
    <String, dynamic>{
      'CustomerUIMetadataContainerDTOList':
          instance.customerUIMetadataContainerDTOList,
    };

CustomerUIMetaData _$CustomerUIMetaDataFromJson(Map<String, dynamic> json) =>
    CustomerUIMetaData(
      json['CustomerFieldOrder'] as int,
      json['CustomerFieldName'] as String,
      json['EntityFieldCaption'] as String,
      json['CustomerFieldValues'],
      json['CustomerFieldType'] as String,
      json['ValidationType'] as String,
      json['FieldLength'] as String,
    );

Map<String, dynamic> _$CustomerUIMetaDataToJson(CustomerUIMetaData instance) {
  final val = <String, dynamic>{
    'CustomerFieldOrder': instance.customerFieldOrder,
    'CustomerFieldName': instance.customerFieldName,
    'EntityFieldCaption': instance.entityFieldCaption,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CustomerFieldValues', instance.customerFieldValues);
  val['CustomerFieldType'] = instance.customerFieldType;
  val['ValidationType'] = instance.validationType;
  val['FieldLength'] = instance.fieldLength;
  return val;
}
