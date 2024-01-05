// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryDataResponse _$CountryDataResponseFromJson(Map<String, dynamic> json) =>
    CountryDataResponse(
      (json['CountryContainerDTOList'] as List<dynamic>)
          .map((e) => CountryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryDataResponseToJson(
        CountryDataResponse instance) =>
    <String, dynamic>{
      'CountryContainerDTOList': instance.CountryContainerDTOList,
    };

CountryData _$CountryDataFromJson(Map<String, dynamic> json) => CountryData(
      json['CountryId'] as int,
      json['CountryName'] as String,
      json['CountryCode'] as String,
      json['IsActive'] as bool,
      (json['StateContainerDTOList'] as List<dynamic>)
          .map((e) => StateContainerDTOList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryDataToJson(CountryData instance) =>
    <String, dynamic>{
      'CountryId': instance.countryId,
      'CountryName': instance.countryName,
      'CountryCode': instance.countryCode,
      'IsActive': instance.isActive,
      'StateContainerDTOList': instance.stateContainerDTOList,
    };

StateContainerDTOList _$StateContainerDTOListFromJson(
        Map<String, dynamic> json) =>
    StateContainerDTOList(
      json['StateId'] as int,
      json['State'] as String,
      json['Description'] as String,
      json['CountryId'] as int,
    );

Map<String, dynamic> _$StateContainerDTOListToJson(
        StateContainerDTOList instance) =>
    <String, dynamic>{
      'StateId': instance.stateId,
      'State': instance.state,
      'Description': instance.description,
      'CountryId': instance.countryId,
    };
