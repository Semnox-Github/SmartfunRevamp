import 'package:json_annotation/json_annotation.dart';
part 'user_metadata.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class UserMetaDataResponse {
  final List<CustomerUIMetaData> customerUIMetadataContainerDTOList;

  UserMetaDataResponse(this.customerUIMetadataContainerDTOList);
  factory UserMetaDataResponse.fromJson(Map<String, dynamic> json) => _$UserMetaDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserMetaDataResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CustomerUIMetaData {
  final int customerFieldOrder;
  final int customAttributeId;
  final String customerFieldName;
  final String entityFieldCaption;
  final dynamic customerFieldValues;
  final String customerFieldType;
  final String validationType;
  final String customerFieldValue;
  final String fieldLength;

  CustomerUIMetaData(
    this.customerFieldOrder,
    this.customAttributeId,
    this.customerFieldName,
    this.entityFieldCaption,
    this.customerFieldValues,
    this.customerFieldType,
    this.validationType,
    this.customerFieldValue,
    this.fieldLength,
  );
  factory CustomerUIMetaData.fromJson(Map<String, dynamic> json) => _$CustomerUIMetaDataFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerUIMetaDataToJson(this);
}
