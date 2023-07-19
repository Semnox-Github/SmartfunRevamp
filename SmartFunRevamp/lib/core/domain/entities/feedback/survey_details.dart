import 'package:json_annotation/json_annotation.dart';
part 'survey_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CustomerFeedbackResponseValues {
  final String responseValue;
  final double score;
  final bool isActive;

  CustomerFeedbackResponseValues(
    this.responseValue,
    this.score,
    this.isActive,
  );
  factory CustomerFeedbackResponseValues.fromJson(Map<String, dynamic> json) => _$CustomerFeedbackResponseValuesFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerFeedbackResponseValuesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class QuestionResponse {
  @JsonKey(name: 'CustomerFeedbackResponseValuesDTOList')
  final List<CustomerFeedbackResponseValues>? responseValues;
  final bool isActive;

  QuestionResponse(this.responseValues, this.isActive);
  factory QuestionResponse.fromJson(Map<String, dynamic> json) => _$QuestionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class SurveyQuestion {
  final QuestionResponse questionResponse;
  final String questionNo;
  final String question;
  final bool isActive;

  SurveyQuestion(this.questionResponse, this.questionNo, this.question, this.isActive);
  factory SurveyQuestion.fromJson(Map<String, dynamic> json) => _$SurveyQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyQuestionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class SurveyDetails {
  final SurveyQuestion surveyQuestion;

  SurveyDetails(this.surveyQuestion);
  factory SurveyDetails.fromJson(Map<String, dynamic> json) => _$SurveyDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class SurveyDetailsResponse {
  final List<SurveyDetails> surveyDetails;

  SurveyDetailsResponse(this.surveyDetails);

  factory SurveyDetailsResponse.fromJson(Map<String, dynamic> json) => _$SurveyDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyDetailsResponseToJson(this);
}
