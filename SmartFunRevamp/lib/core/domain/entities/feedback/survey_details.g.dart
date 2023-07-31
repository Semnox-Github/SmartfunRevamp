// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerFeedbackResponseValues _$CustomerFeedbackResponseValuesFromJson(
        Map<String, dynamic> json) =>
    CustomerFeedbackResponseValues(
      json['ResponseValue'] as String,
      (json['Score'] as num).toDouble(),
      json['IsActive'] as bool,
    );

Map<String, dynamic> _$CustomerFeedbackResponseValuesToJson(
        CustomerFeedbackResponseValues instance) =>
    <String, dynamic>{
      'ResponseValue': instance.responseValue,
      'Score': instance.score,
      'IsActive': instance.isActive,
    };

QuestionResponse _$QuestionResponseFromJson(Map<String, dynamic> json) =>
    QuestionResponse(
      (json['CustomerFeedbackResponseValuesDTOList'] as List<dynamic>?)
          ?.map((e) => CustomerFeedbackResponseValues.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      json['IsActive'] as bool,
    );

Map<String, dynamic> _$QuestionResponseToJson(QuestionResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'CustomerFeedbackResponseValuesDTOList', instance.responseValues);
  val['IsActive'] = instance.isActive;
  return val;
}

SurveyQuestion _$SurveyQuestionFromJson(Map<String, dynamic> json) =>
    SurveyQuestion(
      QuestionResponse.fromJson(
          json['QuestionResponse'] as Map<String, dynamic>),
      json['QuestionNo'] as String,
      json['Question'] as String,
      json['IsActive'] as bool,
    );

Map<String, dynamic> _$SurveyQuestionToJson(SurveyQuestion instance) =>
    <String, dynamic>{
      'QuestionResponse': instance.questionResponse,
      'QuestionNo': instance.questionNo,
      'Question': instance.question,
      'IsActive': instance.isActive,
    };

SurveyDetails _$SurveyDetailsFromJson(Map<String, dynamic> json) =>
    SurveyDetails(
      SurveyQuestion.fromJson(json['SurveyQuestion'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SurveyDetailsToJson(SurveyDetails instance) =>
    <String, dynamic>{
      'SurveyQuestion': instance.surveyQuestion,
    };

SurveyDetailsResponse _$SurveyDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    SurveyDetailsResponse(
      (json['SurveyDetails'] as List<dynamic>)
          .map((e) => SurveyDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SurveyDetailsResponseToJson(
        SurveyDetailsResponse instance) =>
    <String, dynamic>{
      'SurveyDetails': instance.surveyDetails,
    };
