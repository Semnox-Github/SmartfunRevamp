// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_metadataui.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUIMetaDataResponse _$UserUIMetaDataResponseFromJson(
        Map<String, dynamic> json) =>
    UserUIMetaDataResponse(
      (json['CustomerFieldConfigurationContainerDTOList'] as List<dynamic>)
          .map((e) =>
              CustomerFieldConfiguration.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['Hash'] as String,
    );

Map<String, dynamic> _$UserUIMetaDataResponseToJson(
        UserUIMetaDataResponse instance) =>
    <String, dynamic>{
      'CustomerFieldConfigurationContainerDTOList':
          instance.customerFieldConfigurationContainerDTOList,
      'Hash': instance.hash,
    };

CustomerFieldConfiguration _$CustomerFieldConfigurationFromJson(
        Map<String, dynamic> json) =>
    CustomerFieldConfiguration(
      json['FieldName'] as String,
      json['Description'] as String,
      json['EntityFieldName'] as String,
      json['Primarygroup'] as String,
      json['SubGroup'] as String,
      json['FieldOrder'] as String,
      json['FieldLabel'] as String,
      json['FieldType'] as String,
      json['CustomeAttributeId'] as int,
      json['FixedFieldAttributeId'] as int,
      json['DisplayFormat'] as String,
      json['DefaultValue'] as String,
      json['IsReadOnly'] as bool,
      json['IsDisplayed'] as bool,
      json['IsMandatory'] as bool,
      json['IsUnique'] as bool,
      json['IsCompositeUnique'] as bool,
      json['MinLength'] as int,
      json['MaxLength'] as int,
      json['SpecificLength'] as String,
      json['ValidationType'] as String,
      json['RegexValue'] as String,
      json['CustomerFieldValueList'],
    );

Map<String, dynamic> _$CustomerFieldConfigurationToJson(
    CustomerFieldConfiguration instance) {
  final val = <String, dynamic>{
    'FieldName': instance.fieldName,
    'Description': instance.description,
    'EntityFieldName': instance.entityFieldName,
    'Primarygroup': instance.primarygroup,
    'SubGroup': instance.subGroup,
    'FieldOrder': instance.fieldOrder,
    'FieldLabel': instance.fieldLabel,
    'FieldType': instance.fieldType,
    'CustomeAttributeId': instance.customeAttributeId,
    'FixedFieldAttributeId': instance.fixedFieldAttributeId,
    'DisplayFormat': instance.displayFormat,
    'DefaultValue': instance.defaultValue,
    'IsReadOnly': instance.isReadOnly,
    'IsDisplayed': instance.isDisplayed,
    'IsMandatory': instance.isMandatory,
    'IsUnique': instance.isUnique,
    'IsCompositeUnique': instance.isCompositeUnique,
    'MinLength': instance.minLength,
    'MaxLength': instance.maxLength,
    'SpecificLength': instance.specificLength,
    'ValidationType': instance.validationType,
    'RegexValue': instance.regexValue,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CustomerFieldValueList', instance.customerFieldValueList);
  return val;
}

CustomerFieldValue _$CustomerFieldValueFromJson(Map<String, dynamic> json) =>
    CustomerFieldValue(
      json['Key'] as String,
      json['Value'] as String,
    );

Map<String, dynamic> _$CustomerFieldValueToJson(CustomerFieldValue instance) =>
    <String, dynamic>{
      'Key': instance.key,
      'Value': instance.value,
    };
