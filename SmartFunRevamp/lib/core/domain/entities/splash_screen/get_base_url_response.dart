import 'package:json_annotation/json_annotation.dart';
part 'get_base_url_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class GetBaseUrlResponse {
  final String appId;
  final String releaseNumber;
  final String gateWayURL;
  final String deprecated;

  GetBaseUrlResponse(
    this.appId,
    this.releaseNumber,
    this.gateWayURL,
    this.deprecated,
  );
  factory GetBaseUrlResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBaseUrlResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetBaseUrlResponseToJson(this);
}
