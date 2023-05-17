import 'package:json_annotation/json_annotation.dart';
part 'lookups_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class LookupsContainer{
  final List<LookupsContainerDTOList> lookupsContainerDTOList;

  LookupsContainer(
    this.lookupsContainerDTOList,
  );

  factory LookupsContainer.fromJson(Map<String, dynamic> json) => _$LookupsContainerFromJson(json);
  Map<String, dynamic> toJson() => _$LookupsContainerToJson(this);

}

@JsonSerializable(fieldRename: FieldRename.pascal)
class LookupsContainerDTOList{
  final int lookupId;
  final String lookupName;
  final String isProtected;
  final List<LookupValuesContainerDTOList> lookupValuesContainerDTOList;

  LookupsContainerDTOList(
    this.lookupId,
    this.lookupName,
    this.isProtected,
    this.lookupValuesContainerDTOList,
  );  
  factory LookupsContainerDTOList.fromJson(Map<String, dynamic> json) => _$LookupsContainerDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$LookupsContainerDTOListToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class LookupValuesContainerDTOList{
  final int? loolkupValueId;
  final String? lookupValue;
  final String? description;
  final String? lookupName;

  LookupValuesContainerDTOList(
    this.loolkupValueId,
    this.lookupValue,
    this.description,
    this.lookupName,
  );

  factory LookupValuesContainerDTOList.fromJson(Map<String, dynamic> json) => _$LookupValuesContainerDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$LookupValuesContainerDTOListToJson(this);

}