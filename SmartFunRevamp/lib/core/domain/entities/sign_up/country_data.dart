import 'package:json_annotation/json_annotation.dart';
part 'country_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CountryDataResponse {
  final List<CountryData> CountryContainerDTOList;

  CountryDataResponse(this.CountryContainerDTOList);
  factory CountryDataResponse.fromJson(Map<String, dynamic> json) => _$CountryDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CountryDataResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CountryData{
  int countryId;
  String countryName;
  String countryCode;
  bool isActive;
  List<StateContainerDTOList> stateContainerDTOList;

  CountryData(
      this.countryId,
        this.countryName,
        this.countryCode,
        this.isActive,
        this.stateContainerDTOList);

  factory CountryData.fromJson(Map<String, dynamic> json) => _$CountryDataFromJson(json);
  Map<String, dynamic> toJson() => _$CountryDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class StateContainerDTOList {
  int stateId;
  String state;
  String description;
  int countryId;

  StateContainerDTOList(this.stateId, this.state, this.description,
      this.countryId);

  factory StateContainerDTOList.fromJson(Map<String, dynamic> json) => _$StateContainerDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$StateContainerDTOListToJson(this);
}
