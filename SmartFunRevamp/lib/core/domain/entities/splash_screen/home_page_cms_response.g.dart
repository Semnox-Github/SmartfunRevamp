// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_cms_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePageCMSResponse _$HomePageCMSResponseFromJson(Map<String, dynamic> json) =>
    HomePageCMSResponse(
      json['ModuleId'] as int?,
      json['Description'] as String?,
      json['Title'] as String?,
      (json['CMSModulePageDTOList'] as List<dynamic>?)
          ?.map((e) => CMSModulePage.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['CMSModuleMenuDTOList'] as List<dynamic>)
          .map((e) => CMSModuleMenu.fromJson(e as Map<String, dynamic>))
          .toList(),
      CMSImages.fromJson(json['images'] as Map<String, dynamic>),
      json['CMSModuleColorsHome'] == null
          ? null
          : CMSModuleColorsHome.fromJson(
              json['CMSModuleColorsHome'] as Map<String, dynamic>),
      json['CardsColor'] == null
          ? null
          : CardsColor.fromJson(json['CardsColor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomePageCMSResponseToJson(HomePageCMSResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ModuleId', instance.moduleId);
  writeNotNull('Description', instance.description);
  writeNotNull('Title', instance.title);
  writeNotNull('CMSModulePageDTOList',
      instance.cmsModulePages?.map((e) => e.toJson()).toList());
  val['CMSModuleMenuDTOList'] =
      instance.cmsModuleMenu.map((e) => e.toJson()).toList();
  val['images'] = instance.cmsImages.toJson();
  writeNotNull('CMSModuleColorsHome', instance.cmsModuleColorsHome?.toJson());
  writeNotNull('CardsColor', instance.cardsColor?.toJson());
  return val;
}

CardsColor _$CardsColorFromJson(Map<String, dynamic> json) => CardsColor(
      json['regular'] as String?,
      json['expired'] as String?,
      json['virtual'] as String?,
    );

Map<String, dynamic> _$CardsColorToJson(CardsColor instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('regular', instance.regular);
  writeNotNull('expired', instance.expired);
  writeNotNull('virtual', instance.virtual);
  return val;
}

CMSModuleColorsHome _$CMSModuleColorsHomeFromJson(Map<String, dynamic> json) =>
    CMSModuleColorsHome(
      json['upper_half'] as String,
      json['middle'] as String,
      json['bottom_half'] as String,
      (json['profile_picture_gradient'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CMSModuleColorsHomeToJson(
        CMSModuleColorsHome instance) =>
    <String, dynamic>{
      'upper_half': instance.upperHalf,
      'middle': instance.middle,
      'bottom_half': instance.bottomHalf,
      'profile_picture_gradient': instance.profilePictureGradient,
    };

CMSModulePage _$CMSModulePageFromJson(Map<String, dynamic> json) =>
    CMSModulePage(
      json['PageId'] as int,
      json['ContentId'] as int,
      json['DisplaySection'] as String,
      json['DisplayOrder'] as int,
      json['ContentURL'] as String,
      json['Source'] as String,
      json['DisplayAttributes'] as String,
      json['ContentKey'] as String,
    );

Map<String, dynamic> _$CMSModulePageToJson(CMSModulePage instance) =>
    <String, dynamic>{
      'PageId': instance.pageId,
      'ContentId': instance.contentId,
      'DisplaySection': instance.displaySection,
      'DisplayOrder': instance.displayOrder,
      'ContentURL': instance.contentURL,
      'Source': instance.source,
      'DisplayAttributes': instance.displayAttributes,
      'ContentKey': instance.contentKey,
    };

ModulePageItemDisplayAttributes _$ModulePageItemDisplayAttributesFromJson(
        Map<String, dynamic> json) =>
    ModulePageItemDisplayAttributes(
      json['BackgroundColor'] as String,
    );

Map<String, dynamic> _$ModulePageItemDisplayAttributesToJson(
        ModulePageItemDisplayAttributes instance) =>
    <String, dynamic>{
      'BackgroundColor': instance.backgroundColor,
    };

CMSModuleMenu _$CMSModuleMenuFromJson(Map<String, dynamic> json) =>
    CMSModuleMenu(
      (json['CMSMenusDTOList'] as List<dynamic>)
          .map((e) => CMSMenu.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CMSModuleMenuToJson(CMSModuleMenu instance) =>
    <String, dynamic>{
      'CMSMenusDTOList': instance.cmsMenus.map((e) => e.toJson()).toList(),
    };

CMSMenu _$CMSMenuFromJson(Map<String, dynamic> json) => CMSMenu(
      (json['CMSMenuItemsDTOList'] as List<dynamic>)
          .map((e) => CMSMenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['Name'] as String,
      json['Active'] as bool,
      json['Type'] as String,
    );

Map<String, dynamic> _$CMSMenuToJson(CMSMenu instance) => <String, dynamic>{
      'CMSMenuItemsDTOList':
          instance.cmsMenuItems.map((e) => e.toJson()).toList(),
      'Name': instance.name,
      'Type': instance.type,
      'Active': instance.active,
    };

CMSMenuItem _$CMSMenuItemFromJson(Map<String, dynamic> json) => CMSMenuItem(
      json['ItemName'] as String,
      json['DisplayName'] as String,
      json['Active'] as bool,
      json['DisplayOrder'] as int,
      json['ItemUrl'] as String,
      json['Target'] as String?,
    );

Map<String, dynamic> _$CMSMenuItemToJson(CMSMenuItem instance) {
  final val = <String, dynamic>{
    'ItemName': instance.itemName,
    'DisplayName': instance.displayName,
    'Active': instance.active,
    'DisplayOrder': instance.displayOrder,
    'ItemUrl': instance.itemUrl,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Target', instance.target);
  return val;
}

CMSImages _$CMSImagesFromJson(Map<String, dynamic> json) => CMSImages(
      json['splash_screen_image_path'] as String,
      json['language_pick_image_path'] as String,
      json['reset_password_image_path'] as String?,
    );

Map<String, dynamic> _$CMSImagesToJson(CMSImages instance) {
  final val = <String, dynamic>{
    'splash_screen_image_path': instance.splashScreenPath,
    'language_pick_image_path': instance.languagePickImagePath,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('reset_password_image_path', instance.resetPasswordImagePath);
  return val;
}
