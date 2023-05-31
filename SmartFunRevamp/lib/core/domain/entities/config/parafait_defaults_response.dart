import 'package:json_annotation/json_annotation.dart';
part 'parafait_defaults_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ParafaitDefaultsResponse {
  static const String passwordKey = 'ENABLE_PASSWORD_ON_SMARTFUN';
  @JsonKey(name: 'ParafaitDefaultContainerDTOList')
  final List<ParafaitDefault> parafaitsDefaults;

  ParafaitDefaultsResponse(this.parafaitsDefaults);
  factory ParafaitDefaultsResponse.fromJson(Map<String, dynamic> json) => _$ParafaitDefaultsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ParafaitDefaultsResponseToJson(this);

  String getDefault(String key) {
    return parafaitsDefaults.firstWhere((element) => element.defaultValueName == key).defaultValue;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class ParafaitDefault {
  final String defaultValueName;
  final String defaultValue;

  ParafaitDefault(this.defaultValueName, this.defaultValue);
  factory ParafaitDefault.fromJson(Map<String, dynamic> json) => _$ParafaitDefaultFromJson(json);
  Map<String, dynamic> toJson() => _$ParafaitDefaultToJson(this);
}
