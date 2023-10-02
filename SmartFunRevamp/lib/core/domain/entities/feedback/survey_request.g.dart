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
      json['CustFbResponseText'] as String,
      DateTime.parse(json['CustFbResponseDate'] as String),
    );

Map<String, dynamic> _$CustomerFeedbackSurveyDataDTOToJson(
    CustomerFeedbackSurveyDataDTO instance) {
  final val = <String, dynamic>{
    'CustFbSurveyDetailId': instance.custFbSurveyDetailId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CustFbResponseValueId', instance.custFbResponseValueId);
  val['CustFbResponseText'] = instance.custFbResponseText;
  val['CustFbResponseDate'] = instance.custFbResponseDate.toIso8601String();
  return val;
}

CustomerFeedbackSurveyMappingDTO _$CustomerFeedbackSurveyMappingDTOFromJson(
        Map<String, dynamic> json) =>
    CustomerFeedbackSurveyMappingDTO(
      json['ObjectId'] as int,
      DateTime.parse(json['CustFbResponseDate'] as String),
    );

Map<String, dynamic> _$CustomerFeedbackSurveyMappingDTOToJson(
        CustomerFeedbackSurveyMappingDTO instance) =>
    <String, dynamic>{
      'ObjectId': instance.objectId,
      'CustFbResponseDate': instance.custFbResponseDate.toIso8601String(),
    };
