// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyRequest _$SurveyRequestFromJson(Map<String, dynamic> json) =>
    SurveyRequest(
      customerFeedbackSurveyDataDTOList:
          (json['CustomerFeedbackSurveyDataDTOList'] as List<dynamic>)
              .map((e) => CustomerFeedbackSurveyDataDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      customerFeedbackSurveyMappingDTOList:
          (json['CustomerFeedbackSurveyMappingDTOList'] as List<dynamic>)
              .map((e) => CustomerFeedbackSurveyMappingDTO.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$SurveyRequestToJson(SurveyRequest instance) =>
    <String, dynamic>{
      'CustomerFeedbackSurveyDataDTOList': instance
          .customerFeedbackSurveyDataDTOList
          .map((e) => e.toJson())
          .toList(),
      'CustomerFeedbackSurveyMappingDTOList': instance
          .customerFeedbackSurveyMappingDTOList
          .map((e) => e.toJson())
          .toList(),
    };

CustomerFeedbackSurveyDataDTO _$CustomerFeedbackSurveyDataDTOFromJson(
        Map<String, dynamic> json) =>
    CustomerFeedbackSurveyDataDTO(
      json['CustFbSurveyDetailId'] as int,
      json['CustFbResponseValueId'] as int?,
      json['CustFbResponseText'] as String?,
      json['CustFbResponseDate'] as String,
      custFbSurveyDataId: json['CustFbSurveyDataId'] as int? ?? -1,
      custFbSurveyDataSetId: json['CustFbSurveyDataSetId'] as int? ?? -1,
      isActive: json['IsActive'] as bool? ?? true,
      isChanged: json['IsChanged'] as bool? ?? true,
    );

Map<String, dynamic> _$CustomerFeedbackSurveyDataDTOToJson(
    CustomerFeedbackSurveyDataDTO instance) {
  final val = <String, dynamic>{
    'CustFbSurveyDataId': instance.custFbSurveyDataId,
    'CustFbSurveyDataSetId': instance.custFbSurveyDataSetId,
    'CustFbSurveyDetailId': instance.custFbSurveyDetailId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CustFbResponseValueId', instance.custFbResponseValueId);
  writeNotNull('CustFbResponseText', instance.custFbResponseText);
  val['CustFbResponseDate'] = instance.custFbResponseDate;
  val['IsActive'] = instance.isActive;
  val['IsChanged'] = instance.isChanged;
  return val;
}

CustomerFeedbackSurveyMappingDTO _$CustomerFeedbackSurveyMappingDTOFromJson(
        Map<String, dynamic> json) =>
    CustomerFeedbackSurveyMappingDTO(
      json['ObjectId'] as int,
      json['CustFbResponseDate'] as String,
      custFbSurveyMapId: json['CustFbSurveyMapId'] as int? ?? -1,
      objectName: json['ObjectName'] as String? ?? "TRX_HEADER",
      custFbSurveyDataSetId: json['CustFbSurveyDataSetId'] as int? ?? -1,
      visitCount: json['VisitCount'] as int? ?? 0,
      lastCustFbSurveyDetailId: json['LastCustFbSurveyDetailId'] as int? ?? 1,
      isActive: json['IsActive'] as bool? ?? true,
      isChanged: json['IsChanged'] as bool? ?? true,
    );

Map<String, dynamic> _$CustomerFeedbackSurveyMappingDTOToJson(
        CustomerFeedbackSurveyMappingDTO instance) =>
    <String, dynamic>{
      'CustFbSurveyMapId': instance.custFbSurveyMapId,
      'ObjectName': instance.objectName,
      'ObjectId': instance.objectId,
      'CustFbSurveyDataSetId': instance.custFbSurveyDataSetId,
      'VisitCount': instance.visitCount,
      'LastCustFbSurveyDetailId': instance.lastCustFbSurveyDetailId,
      'CustFbResponseDate': instance.custFbResponseDate,
      'IsActive': instance.isActive,
      'IsChanged': instance.isChanged,
    };
