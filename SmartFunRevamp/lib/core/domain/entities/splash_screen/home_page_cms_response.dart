import 'package:json_annotation/json_annotation.dart';
part 'home_page_cms_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class HomePageCMSResponse {
  final int? moduleId;
  final String? description;
  final String? title;
  @JsonKey(name: 'CMSModulePageDTOList')
  final List<CMSModulePage>? cmsModulePages;
  @JsonKey(name: 'CMSModuleMenuDTOList')
  final List<CMSModuleMenuDTOList>? cmsModuleMenu;

  @JsonKey(name: 'images')
  final CMSImages cmsImages;

  HomePageCMSResponse(
    this.moduleId,
    this.description,
    this.title,
    this.cmsModulePages,
    this.cmsModuleMenu,
    this.cmsImages,
  );
  factory HomePageCMSResponse.fromJson(Map<String, dynamic> json) => _$HomePageCMSResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomePageCMSResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CMSModulePage {
  final int pageId;
  final int contentId;
  final String displaySection;
  final int displayOrder;
  final String contentURL;
  Map<String, dynamic> toJson() => _$CMSModulePageToJson(this);

  factory CMSModulePage.fromJson(Map<String, dynamic> json) => _$CMSModulePageFromJson(json);
  CMSModulePage(this.pageId, this.contentId, this.displaySection, this.displayOrder, this.contentURL);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CMSModuleMenuDTOList {
  @JsonKey(name: 'CMSMenuItemsDTOList')
  final List<CMSMenuItem>? cmsMenusList;
  final String? name;
  final String? type;
  CMSModuleMenuDTOList(
    this.cmsMenusList,
    this.name,
    this.type,
  );
  factory CMSModuleMenuDTOList.fromJson(Map<String, dynamic> json) => _$CMSModuleMenuDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$CMSModuleMenuDTOListToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CMSMenuItem {
  final String? itemName;
  final String? displayName;

  CMSMenuItem(this.itemName, this.displayName);
  factory CMSMenuItem.fromJson(Map<String, dynamic> json) => _$CMSMenuItemFromJson(json);
  Map<String, dynamic> toJson() => _$CMSMenuItemToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CMSImages {
  @JsonKey(name: 'splash_screen_image_path')
  final String splashScreenPath;
  @JsonKey(name: 'language_pick_image_path')
  final String languagePickImagePath;
  CMSImages(this.splashScreenPath, this.languagePickImagePath);
  factory CMSImages.fromJson(Map<String, dynamic> json) => _$CMSImagesFromJson(json);
  Map<String, dynamic> toJson() => _$CMSImagesToJson(this);
}
