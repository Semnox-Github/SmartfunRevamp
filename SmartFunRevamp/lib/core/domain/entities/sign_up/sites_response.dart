import 'package:json_annotation/json_annotation.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';
part 'sites_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class GetAllSitesResponse {
  final List<SiteViewDTO> siteContainerDTOList;

  GetAllSitesResponse(this.siteContainerDTOList);
  factory GetAllSitesResponse.fromJson(Map<String, dynamic> json) => _$GetAllSitesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllSitesResponseToJson(this);
}
