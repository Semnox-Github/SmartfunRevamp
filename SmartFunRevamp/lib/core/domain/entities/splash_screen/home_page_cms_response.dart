import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/language/language_container_dto.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
part 'home_page_cms_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class HomePageCMSResponse {
  final int? moduleId;
  final String? description;
  final String? title;
  @JsonKey(name: 'CMSModulePageDTOList')
  final List<CMSModulePage>? cmsModulePages;
  @JsonKey(name: 'CMSModuleMenuDTOList')
  final List<CMSModuleMenu> cmsModuleMenu;
  @JsonKey(name: 'images')
  final CMSImages cmsImages;
  @JsonKey(name: 'CMSModuleColorsHome')
  final CMSModuleColorsHome? cmsModuleColorsHome;
  @JsonKey(name: 'CardsColor')
  final CardsColor? cardsColor;

  HomePageCMSResponse(this.moduleId, this.description, this.title, this.cmsModulePages, this.cmsModuleMenu,
      this.cmsImages, this.cmsModuleColorsHome, this.cardsColor);
  factory HomePageCMSResponse.fromJson(Map<String, dynamic> json) => _$HomePageCMSResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomePageCMSResponseToJson(this);

  List<CMSMenuItem> geMenuItems(String type) {
    List<CMSMenuItem> cmsMenuItems = [];
    for (CMSModuleMenu moduleMenu in cmsModuleMenu) {
      for (CMSMenu menu in moduleMenu.cmsMenus) {
        if (menu.type == type) {
          cmsMenuItems = menu.cmsMenuItems;
        }
      }
    }
    cmsMenuItems.sort((a, b) => a.displayOrder < b.displayOrder ? -1 : 1);
    return cmsMenuItems;
  }

  List<CMSMenuItem> getFooterMenuItems() {
    final footerItems = geMenuItems('FOOTER');
    footerItems.removeWhere((element) => element.active == false);
    return footerItems;
  }

  List<CMSMenuItem> getHeaderMenuItems() {
    return geMenuItems('HEADER');
  }

  List<CMSMenuItem> getCardDetailMenuItems() {
    return geMenuItems('CARD_DETAILS');
  }

  List<CMSMenuItem> getMoreMenuItems() {
    return geMenuItems('MORE');
  }

  List<CMSModulePage> getQuickLinks() {
    final quickLinksStart = cmsModulePages?.indexWhere((element) => element.source == "QUICKLINKS");
    if (quickLinksStart == null) {
      return [];
    }
    final quickLinksEnd = cmsModulePages?.indexWhere((element) => element.source == "More Actions");
    final quickLinks = cmsModulePages?.sublist((quickLinksStart) + 1, quickLinksEnd) ?? [];
    quickLinks.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    return quickLinks;
  }

  List<CMSModulePage> getMoreActions() {
    final quickLinksStart = cmsModulePages?.indexWhere((element) => element.source == "More Actions");
    if (quickLinksStart == null) {
      return [];
    }
    final moreActions = cmsModulePages?.sublist((quickLinksStart) + 1) ?? [];
    moreActions.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    return moreActions;
  }

  Uri? playUrl({required LanguageContainerDTOList? currentLang, required String siteId}) {
    final footerItems = geMenuItems('FOOTER');
    final playUrlFromCMS = footerItems.firstWhereOrNull((element) => element.itemName == 'PLAY')?.target;
    debugPrint('thisistheplayurl from CMS: $playUrlFromCMS');
    if (playUrlFromCMS == null) {
      return null;
    }
    final customer = Get.find<CustomerDTO>();
    final Map<String, String> replacements = {
      'customerId': customer.id.toString(),
      'customerID': customer.id.toString(),
      'langCode': currentLang?.languageCode ?? 'en-US',
      'siteID': siteId,
      'posMachine': 'CustomerApp',
      'userID': 'SmartFun',
      'apiURL': Get.find<String>(tag: 'baseURL'),
    };
    String playUrl = playUrlFromCMS;
    replacements.forEach((key, value) {
      playUrl = playUrl.replaceAll('@$key', value);
    });

    debugPrint('thisistheplayurl: $playUrl');
    return Uri.parse(playUrl);
  }
}

@JsonSerializable(explicitToJson: true)
class CardsColor {
  final String? regular;
  final String? expired;
  final String? virtual;

  CardsColor(this.regular, this.expired, this.virtual);
  factory CardsColor.fromJson(Map<String, dynamic> json) => _$CardsColorFromJson(json);
  Map<String, dynamic> toJson() => _$CardsColorToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CMSModuleColorsHome {
  final String upperHalf;
  final String middle;
  final String bottomHalf;
  @JsonKey(name: "profile_picture_gradient")
  final List<String> profilePictureGradient;

  CMSModuleColorsHome(
    this.upperHalf,
    this.middle,
    this.bottomHalf,
    this.profilePictureGradient,
  );
  factory CMSModuleColorsHome.fromJson(Map<String, dynamic> json) => _$CMSModuleColorsHomeFromJson(json);
  Map<String, dynamic> toJson() => _$CMSModuleColorsHomeToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class CMSModulePage {
  final int pageId;
  final int contentId;
  final String displaySection;
  final int displayOrder;
  final String contentURL;
  final String source;
  final String displayAttributes;
  final String contentKey;

  CMSModulePage(
    this.pageId,
    this.contentId,
    this.displaySection,
    this.displayOrder,
    this.contentURL,
    this.source,
    this.displayAttributes,
    this.contentKey,
  );

  Map<String, dynamic> toJson() => _$CMSModulePageToJson(this);

  factory CMSModulePage.fromJson(Map<String, dynamic> json) => _$CMSModulePageFromJson(json);

  Color get backgroundColor {
    final temp = displayAttributes.toString().replaceAll(r'\\', '');
    final Map<String, dynamic> cleanedJson = json.decode(temp);
    final colorHex = cleanedJson['BackgroundColor'] as String;
    return HexColor.fromHex(colorHex) ?? CustomColors.customPink;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class ModulePageItemDisplayAttributes {
  final String backgroundColor;

  ModulePageItemDisplayAttributes(this.backgroundColor);
  factory ModulePageItemDisplayAttributes.fromJson(Map<String, dynamic> map) {
    Logger().i(map);
    final temp = map.toString().replaceAll(r'\\', '');
    final Map<String, dynamic> cleanedJson = json.decode(temp);
    return _$ModulePageItemDisplayAttributesFromJson(cleanedJson);
  }
  Map<String, dynamic> toJson() => _$ModulePageItemDisplayAttributesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class CMSModuleMenu {
  @JsonKey(name: 'CMSMenusDTOList')
  final List<CMSMenu> cmsMenus;
  CMSModuleMenu(
    this.cmsMenus,
  );
  factory CMSModuleMenu.fromJson(Map<String, dynamic> json) => _$CMSModuleMenuFromJson(json);
  Map<String, dynamic> toJson() => _$CMSModuleMenuToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class CMSMenu {
  @JsonKey(name: 'CMSMenuItemsDTOList')
  final List<CMSMenuItem> cmsMenuItems;
  final String name;
  final String type;
  final bool active;
  CMSMenu(
    this.cmsMenuItems,
    this.name,
    this.active,
    this.type,
  );
  factory CMSMenu.fromJson(Map<String, dynamic> json) => _$CMSMenuFromJson(json);
  Map<String, dynamic> toJson() => _$CMSMenuToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class CMSMenuItem {
  final String itemName;
  final String displayName;
  final bool active;
  final int displayOrder;
  final String itemUrl;
  final String? target;
  final String? description;
  final int? creditType;
  CMSMenuItem(
    this.itemName,
    this.displayName,
    this.active,
    this.displayOrder,
    this.itemUrl,
    this.target,
    this.description,
    this.creditType,
  );
  factory CMSMenuItem.fromJson(Map<String, dynamic> json) => _$CMSMenuItemFromJson(json);
  Map<String, dynamic> toJson() => _$CMSMenuItemToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CMSImages {
  @JsonKey(name: 'splash_screen_image_path')
  final String splashScreenPath;
  @JsonKey(name: 'language_pick_image_path')
  final String languagePickImagePath;
  final String? resetPasswordImagePath;
  CMSImages(
    this.splashScreenPath,
    this.languagePickImagePath,
    this.resetPasswordImagePath,
  );
  factory CMSImages.fromJson(Map<String, dynamic> json) => _$CMSImagesFromJson(json);
  Map<String, dynamic> toJson() => _$CMSImagesToJson(this);
}
