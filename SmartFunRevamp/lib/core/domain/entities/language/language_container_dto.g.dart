// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_container_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageContainerDTO _$LanguageContainerDTOFromJson(
        Map<String, dynamic> json) =>
    LanguageContainerDTO(
      (json['LanguageContainerDTOList'] as List<dynamic>)
          .map((e) =>
              LanguageContainerDTOList.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['Hash'] as String,
    );

Map<String, dynamic> _$LanguageContainerDTOToJson(
        LanguageContainerDTO instance) =>
    <String, dynamic>{
      'LanguageContainerDTOList':
          instance.languageContainerDTOList.map((e) => e.toJson()).toList(),
      'Hash': instance.hash,
    };

LanguageContainerDTOList _$LanguageContainerDTOListFromJson(
        Map<String, dynamic> json) =>
    LanguageContainerDTOList(
      json['LanguageId'] as int,
      json['LanguageName'] as String,
      json['LanguageCode'] as String,
      json['CultureCode'] as String,
    );

Map<String, dynamic> _$LanguageContainerDTOListToJson(
        LanguageContainerDTOList instance) =>
    <String, dynamic>{
      'LanguageId': instance.languageId,
      'LanguageName': instance.languageName,
      'LanguageCode': instance.languageCode,
      'CultureCode': instance.cultureCode,
    };
