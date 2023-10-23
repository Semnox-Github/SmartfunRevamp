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
  final List<HomePageOrder> homePageOrder;
  final ExternalUrls? externalUrls;
  final List<List<int>>? buyACardFilters;

  HomePageCMSResponse(
    this.moduleId,
    this.description,
    this.title,
    this.cmsModulePages,
    this.cmsModuleMenu,
    this.cmsImages,
    this.cmsModuleColorsHome,
    this.cardsColor,
    this.homePageOrder,
    this.externalUrls,
    this.buyACardFilters,
  );
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

  List<CMSModulePage> getLinks(String displaySection) {
    final links = cmsModulePages?.where((element) => element.displaySection == displaySection).toList() ?? [];
    links.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    return links;
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
  final String contentName;

  CMSModulePage(
    this.pageId,
    this.contentId,
    this.displaySection,
    this.displayOrder,
    this.contentURL,
    this.source,
    this.displayAttributes,
    this.contentKey,
    this.contentName,
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

  @JsonKey(name: 'logo_image_path')
  final String? logoImagePath;
  @JsonKey(name: 'coupon_congrats_image_path')
  final String? couponCongratsImagePath;
  @JsonKey(name: 'blocked_image_path')
  final String? blockedImagePath;
  @JsonKey(name: 'expired_image_path')
  final String? expiredImagePath;
  @JsonKey(name: 'QR_image_path')
  final String? qrImagePath;
  @JsonKey(name: 'coin_image_path')
  final String? coinImagePath;
  @JsonKey(name: 'barcode_image_path')
  final String? barcodeImagePath;
  @JsonKey(name: 'no_promo_image_path')
  final String? noPromoImagePath;
  @JsonKey(name: 'check_ok_image_path')
  final String? checkOkImagePath;
  @JsonKey(name: 'bronze_image_path')
  final String? bronzeImagePath;
  @JsonKey(name: 'silver_image_path')
  final String? silverImagePath;
  @JsonKey(name: 'gold_image_path')
  final String? goldImagePath;
  @JsonKey(name: 'diamond_image_path')
  final String? diamondImagePath;
  @JsonKey(name: 'platinum_image_path')
  final String? platinumImagePath;
  @JsonKey(name: 'payment_failed_image_path')
  final String? paymentFailedImagePath;
  @JsonKey(name: 'recharge_successful_image_path')
  final String? rechargeSuccessfulImagePath;
  @JsonKey(name: 'reset_password_success_image_path')
  final String? resetPasswordSuccessImagePath;
  @JsonKey(name: 'select_location_image_path')
  final String? selectLocationImagePath;
  @JsonKey(name: 'transfer_success_image_path')
  final String? transferSuccessImagePath;
  CMSImages(
    this.splashScreenPath,
    this.languagePickImagePath,
    this.couponCongratsImagePath,
    this.resetPasswordImagePath,
    this.logoImagePath,
    this.blockedImagePath,
    this.expiredImagePath,
    this.qrImagePath,
    this.coinImagePath,
    this.barcodeImagePath,
    this.noPromoImagePath,
    this.checkOkImagePath,
    this.bronzeImagePath,
    this.silverImagePath,
    this.goldImagePath,
    this.diamondImagePath,
    this.platinumImagePath,
    this.paymentFailedImagePath,
    this.rechargeSuccessfulImagePath,
    this.resetPasswordSuccessImagePath,
    this.selectLocationImagePath,
    this.transferSuccessImagePath,
  );
  factory CMSImages.fromJson(Map<String, dynamic> json) => _$CMSImagesFromJson(json);
  Map<String, dynamic> toJson() => _$CMSImagesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class HomePageOrder {
  final int position;
  final String title;
  final String widget;
  final bool isVisible;
  final String? displaySection;
  HomePageOrder(
    this.position,
    this.widget,
    this.title,
    this.isVisible,
    this.displaySection,
  );
  factory HomePageOrder.fromJson(Map<String, dynamic> json) => _$HomePageOrderFromJson(json);
  Map<String, dynamic> toJson() => _$HomePageOrderToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ExternalUrls {
  final String privacyPolicy;
  final String termsAndConditions;
  final String help;
  final String androidPlaystoreLink;
  final String iosAppstoreLink;

  ExternalUrls(
    this.privacyPolicy,
    this.termsAndConditions,
    this.help,
    this.iosAppstoreLink,
    this.androidPlaystoreLink,
  );
  factory ExternalUrls.fromJson(Map<String, dynamic> json) => _$ExternalUrlsFromJson(json);
  Map<String, dynamic> toJson() => _$ExternalUrlsToJson(this);
}
