import 'package:json_annotation/json_annotation.dart';
part 'survey_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class SurveyRequest {
  @JsonKey(name: "CustomerFeedbackSurveyDataDTOList")
  final List<CustomerFeedbackSurveyDataDTO> customerFeedbackSurveyDataDTOList;
  @JsonKey(name: "CustomerFeedbackSurveyMappingDTOList")
  final List<CustomerFeedbackSurveyMappingDTO> customerFeedbackSurveyMappingDTOList;

  SurveyRequest({
    required this.customerFeedbackSurveyDataDTOList,
    required this.customerFeedbackSurveyMappingDTOList,
  });
  factory SurveyRequest.fromJson(Map<String, dynamic> json) => _$SurveyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class CustomerFeedbackSurveyDataDTO {
  final int custFbSurveyDataId;
  final int custFbSurveyDataSetId;
  final int custFbSurveyDetailId;
  final int? custFbResponseValueId;
  final String? custFbResponseText;
  final String custFbResponseDate;
  final bool isActive;
  final bool isChanged;

  CustomerFeedbackSurveyDataDTO(
    this.custFbSurveyDetailId,
    this.custFbResponseValueId,
    this.custFbResponseText,
    this.custFbResponseDate, {
    this.custFbSurveyDataId = -1,
    this.custFbSurveyDataSetId = -1,
    this.isActive = true,
    this.isChanged = true,
  });
  factory CustomerFeedbackSurveyDataDTO.fromJson(Map<String, dynamic> json) =>
      _$CustomerFeedbackSurveyDataDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerFeedbackSurveyDataDTOToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class CustomerFeedbackSurveyMappingDTO {
  final int custFbSurveyMapId;
  final String objectName;
  final int objectId;
  final int custFbSurveyDataSetId;
  final int visitCount;
  final int lastCustFbSurveyDetailId;
  final String custFbResponseDate;
  final bool isActive;
  final bool isChanged;

  CustomerFeedbackSurveyMappingDTO(
    this.objectId,
    this.custFbResponseDate, {
    this.custFbSurveyMapId = -1,
    this.objectName = "TRX_HEADER",
    this.custFbSurveyDataSetId = -1,
    this.visitCount = 0,
    this.lastCustFbSurveyDetailId = 1,
    this.isActive = true,
    this.isChanged = true,
  });
  factory CustomerFeedbackSurveyMappingDTO.fromJson(Map<String, dynamic> json) =>
      _$CustomerFeedbackSurveyMappingDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerFeedbackSurveyMappingDTOToJson(this);
}
