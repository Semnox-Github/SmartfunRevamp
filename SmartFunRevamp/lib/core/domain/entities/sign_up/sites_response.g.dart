// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sites_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllSitesResponse _$GetAllSitesResponseFromJson(Map<String, dynamic> json) =>
    GetAllSitesResponse(
      (json['SiteContainerDTOList'] as List<dynamic>)
          .map((e) => SiteViewDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllSitesResponseToJson(
        GetAllSitesResponse instance) =>
    <String, dynamic>{
      'SiteContainerDTOList':
          instance.siteContainerDTOList.map((e) => e.toJson()).toList(),
    };
