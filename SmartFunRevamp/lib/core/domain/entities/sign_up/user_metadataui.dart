import 'package:json_annotation/json_annotation.dart';

part 'user_metadataui.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class UserUIMetaDataResponse {
 final List<CustomerFieldConfiguration> customerFieldConfigurationContainerDTOList;
 final String hash;

 UserUIMetaDataResponse(this.customerFieldConfigurationContainerDTOList, this.hash);

 factory UserUIMetaDataResponse.fromJson(Map<String, dynamic> json) =>
     _$UserUIMetaDataResponseFromJson(json);

 Map<String, dynamic> toJson() => _$UserUIMetaDataResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CustomerFieldConfiguration {
 final String fieldName;
 final String description;
 final String entityFieldName;
 final String primarygroup;
 final String subGroup;
 final String fieldOrder;
 final String fieldLabel;
 final String fieldType;
 final int customeAttributeId;
 final int fixedFieldAttributeId;
 final String displayFormat;
 final String defaultValue;
 final bool isReadOnly;
 final bool isDisplayed;
 final bool isMandatory;
 final bool isUnique;
 final bool isCompositeUnique;
 final int minLength;
 final int maxLength;
 final String specificLength;
 final String validationType;
 final String regexValue;
 final dynamic customerFieldValueList;
 // final List<CustomerFieldValue> customerFieldValueList;

 CustomerFieldConfiguration(
     this.fieldName,
     this.description,
     this.entityFieldName,
     this.primarygroup,
     this.subGroup,
     this.fieldOrder,
     this.fieldLabel,
     this.fieldType,
     this.customeAttributeId,
     this.fixedFieldAttributeId,
     this.displayFormat,
     this.defaultValue,
     this.isReadOnly,
     this.isDisplayed,
     this.isMandatory,
     this.isUnique,
     this.isCompositeUnique,
     this.minLength,
     this.maxLength,
     this.specificLength,
     this.validationType,
     this.regexValue,
     this.customerFieldValueList,
     );

 factory CustomerFieldConfiguration.fromJson(Map<String, dynamic> json) =>
     _$CustomerFieldConfigurationFromJson(json);

 Map<String, dynamic> toJson() => _$CustomerFieldConfigurationToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CustomerFieldValue {
 final String key;
 final String value;

 CustomerFieldValue(this.key, this.value);

 factory CustomerFieldValue.fromJson(Map<String, dynamic> json) =>
     _$CustomerFieldValueFromJson(json);

 Map<String, dynamic> toJson() => _$CustomerFieldValueToJson(this);
}

