import 'package:json_annotation/json_annotation.dart';
part 'survey_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class SurveyRequest {
  @JsonKey(name: "CustomerFeedbackSurveyDataDTOList")
  final List<CustomerFeedbackSurveyDataDTO> customerFeedbackSurveyDataDTOList;
  @JsonKey(name: "CustomerFeedbackSurveyMappingDTOList")
  final List<CustomerFeedbackSurveyMappingDTO>
      customerFeedbackSurveyMappingDTOList;

  SurveyRequest({
    required this.customerFeedbackSurveyDataDTOList,
    required this.customerFeedbackSurveyMappingDTOList,
  });
  factory SurveyRequest.fromJson(Map<String, dynamic> json) =>
      _$SurveyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class CustomerFeedbackSurveyDataDTO {
  final int custFbSurveyDataId = -1;
  final int custFbSurveyDataSetId = -1;
  final int custFbSurveyDetailId;
  final int? custFbResponseValueId;
  final String custFbResponseText;
  final DateTime custFbResponseDate;
  final bool isActive = true;
  final bool isChanged = true;

  CustomerFeedbackSurveyDataDTO(
    this.custFbSurveyDetailId,
    this.custFbResponseValueId,
    this.custFbResponseText,
    this.custFbResponseDate,
  );
  factory CustomerFeedbackSurveyDataDTO.fromJson(Map<String, dynamic> json) =>
      _$CustomerFeedbackSurveyDataDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerFeedbackSurveyDataDTOToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class CustomerFeedbackSurveyMappingDTO {
  final int custFbSurveyMapId = -1;
  final String objectName = "TRX_HEADER";
  final int objectId;
  final int custFbSurveyDataSetId = -1;
  final int visitCount = 0;
  final int lastCustFbSurveyDetailId = 1;
  final DateTime custFbResponseDate;
  final bool isActive = true;
  final bool isChanged = true;

  CustomerFeedbackSurveyMappingDTO(
    this.objectId,
    this.custFbResponseDate,
  );
  factory CustomerFeedbackSurveyMappingDTO.fromJson(
          Map<String, dynamic> json) =>
      _$CustomerFeedbackSurveyMappingDTOFromJson(json);
  Map<String, dynamic> toJson() =>
      _$CustomerFeedbackSurveyMappingDTOToJson(this);
}
