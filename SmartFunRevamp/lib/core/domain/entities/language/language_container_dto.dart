import 'package:json_annotation/json_annotation.dart';
part 'language_container_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class LanguageContainerDTO {
  final List<LanguageContainerDTOList> languageContainerDTOList;
  final String hash;

  LanguageContainerDTO(this.languageContainerDTOList, this.hash);

  factory LanguageContainerDTO.fromJson(Map<String, dynamic> json) => _$LanguageContainerDTOFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageContainerDTOToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class LanguageContainerDTOList {
  final int languageId;
  final String languageName;
  final String languageCode;
  final String cultureCode;

  LanguageContainerDTOList(this.languageId, this.languageName, this.languageCode, this.cultureCode);

  factory LanguageContainerDTOList.fromJson(Map<String, dynamic> json) => _$LanguageContainerDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageContainerDTOListToJson(this);
}
