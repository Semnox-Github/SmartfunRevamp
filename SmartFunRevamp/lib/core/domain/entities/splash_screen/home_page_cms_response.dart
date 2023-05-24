import 'package:json_annotation/json_annotation.dart';
part 'home_page_cms_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class HomePageCMSResponse {
  final int moduleId;
  final String description;
  final String title;
  @JsonKey(name: 'CMSModulePageDTOList')
  final List<CMSModulePage> cmsModulePages;

  HomePageCMSResponse(
    this.moduleId,
    this.description,
    this.title,
    this.cmsModulePages,
  );
  factory HomePageCMSResponse.fromJson(Map<String, dynamic> json) => _$HomePageCMSResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomePageCMSResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CMSModulePage {
  final int id;
  final int moduleId;
  @JsonKey(name: 'CMSPagesDTOList')
  final List<CMSPages> cmsPages;

  CMSModulePage(this.id, this.moduleId, this.cmsPages);
  factory CMSModulePage.fromJson(Map<String, dynamic> json) => _$CMSModulePageFromJson(json);
  Map<String, dynamic> toJson() => _$CMSModulePageToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CMSPages {
  @JsonKey(name: 'CMSContentDTOList')
  final List<CMSContent> cmsContent;
  @JsonKey(name: 'PageContents')
  final List<CMSContent> pageContent;

  CMSPages(this.cmsContent, this.pageContent);
  factory CMSPages.fromJson(Map<String, dynamic> json) => _$CMSPagesFromJson(json);
  Map<String, dynamic> toJson() => _$CMSPagesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CMSContent {
  final int contentId;
  final String source;
  final int displayOrder;
  final String contentURL;
  final int height;
  final int width;

  CMSContent(
    this.contentId,
    this.source,
    this.displayOrder,
    this.contentURL,
    this.height,
    this.width,
  );
  factory CMSContent.fromJson(Map<String, dynamic> json) => _$CMSContentFromJson(json);
  Map<String, dynamic> toJson() => _$CMSContentToJson(this);
}
