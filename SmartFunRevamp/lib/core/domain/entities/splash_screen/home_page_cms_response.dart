import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/language/language_container_dto.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
part 'home_page_cms_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class HomePageCMSResponse extends ChangeNotifier {
  final int? moduleId;
  final String? description;
  final String? title;
  @JsonKey(name: 'CMSModulePageDTOList')
  final List<CMSModulePage>? cmsModulePages;
  @JsonKey(name: 'CMSModuleMenuDTOList')
  final List<CMSModuleMenu> cmsModuleMenu;
  @JsonKey(name: 'images')
  final CMSImages cmsImages;

  @JsonKey(name: 'ExternalUrls')
  late final ExternalUrls? externalUrls;

  @JsonKey(name: 'CMSPageHeaderStyle')
  late final CMSPageHeader? cmsPageHeader;

  @JsonKey(name: 'CMSPageBodyStyle')
  final CMSPageBodyStyle? cmsBodyStyle;

  @JsonKey(name: 'CMSModuleColorsHome')
  final CMSModuleColorsHome? cmsModuleColorsHome;
  @JsonKey(name: 'CardsColor')
  final CardsColor? cardsColor;
  final List<HomePageOrder> homePageOrder;
  final List<List<int>>? buyACardFilters;
  @JsonKey(name: 'CMSButtonStyle')
  final CMSButtonStyle? buttonStyle;

  HomePageCMSResponse(
      this.moduleId,
      this.description,
      this.title,
      this.cmsModulePages,
      this.cmsModuleMenu,
      this.cmsImages,
      this.cmsPageHeader,
      this.cmsBodyStyle,
      this.cmsModuleColorsHome,
      this.cardsColor,
      this.homePageOrder,
      this.buyACardFilters,
      this.buttonStyle,
      this.externalUrls);

  // CMSPageHeader? get cmsPageHeaderStyle => cmsPageHeader;

  // set cmsPageHeaderStyle(CMSPageHeader? value) {
  //   cmsPageHeader = value;
  //   notifyListeners();
  // }

  factory HomePageCMSResponse.fromJson(Map<String, dynamic> json) =>
      _$HomePageCMSResponseFromJson(json);
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
    cmsMenuItems.removeWhere((element) => !element.active);
    cmsMenuItems.retainWhere((element) =>
        element.platform == null ||
        element.platform == Platform.operatingSystem);
    return cmsMenuItems;
  }

  List<CMSMenuItem> getFooterMenuItems() {
    return geMenuItems('FOOTER');
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

  List<CMSMenuItem> getCardDetailsLinks() {
    return geMenuItems('CARD_DETAILS_LINKS');
  }

  List<CMSModulePage> getLinks(String displaySection) {
    final links = cmsModulePages
            ?.where((element) => element.displaySection == displaySection)
            .toList() ??
        [];
    links.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    return links;
  }

  Uri? playUrl(
      {required LanguageContainerDTOList? currentLang,
      required String siteId}) {
    final footerItems = geMenuItems('FOOTER');
    final playUrlFromCMS = footerItems
        .firstWhereOrNull((element) => element.itemName == 'PLAY')
        ?.target;
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

    return Uri.parse(playUrl);
  }
}

@JsonSerializable(explicitToJson: true)
class CardsColor {
  final String? regular;
  final String? expired;
  final String? virtual;
  final String? colorCardText;
  final List<String>? silverGradient;
  final List<String>? goldGradient;
  final List<String>? platinumGradient;

  CardsColor(
    this.regular,
    this.expired,
    this.virtual,
    this.colorCardText,
    this.silverGradient,
    this.goldGradient,
    this.platinumGradient,
  );
  factory CardsColor.fromJson(Map<String, dynamic> json) =>
      _$CardsColorFromJson(json);
  Map<String, dynamic> toJson() => _$CardsColorToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CMSModuleColorsHome {
  final String upperHalf;
  final String middle;
  final String bottomHalf;
  @JsonKey(name: "profile_TextColor")
  final String profileTextColor;
  @JsonKey(name: "profile_picture_gradient")
  final List<String> profilePictureGradient;
  //@JsonKey(name: "profile_TextColor")
  //final String profileTextColor;

  CMSModuleColorsHome(this.upperHalf, this.middle, this.bottomHalf,
      this.profileTextColor, this.profilePictureGradient);
  factory CMSModuleColorsHome.fromJson(Map<String, dynamic> json) =>
      _$CMSModuleColorsHomeFromJson(json);
  Map<String, dynamic> toJson() => _$CMSModuleColorsHomeToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CMSButtonStyle {
  final PrimaryButtonStyle? primaryButtonStyle;
  final SecondaryButtonStyle? secondaryButtonStyle;

  CMSButtonStyle(this.primaryButtonStyle, this.secondaryButtonStyle);

  factory CMSButtonStyle.fromJson(Map<String, dynamic> json) =>
      _$CMSButtonStyleFromJson(json);
  Map<String, dynamic> toJson() => _$CMSButtonStyleToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PrimaryButtonStyle {
  final List<String> buttonColorGradient;
  final String buttonTextColor;

  PrimaryButtonStyle(this.buttonColorGradient, this.buttonTextColor);

  factory PrimaryButtonStyle.fromJson(Map<String, dynamic> json) =>
      _$PrimaryButtonStyleFromJson(json);
  Map<String, dynamic> toJson() => _$PrimaryButtonStyleToJson(this);
}

class CMSPageHeader {
  final String backgroundColor;
  final String textColor;
  CMSPageHeader(this.backgroundColor, this.textColor);

  Map<String, dynamic> toJson() => _$CMSPageHeaderToJson(this);

  factory CMSPageHeader.fromJson(Map<String, dynamic> json) =>
      _$CMSPageHeaderFromJson(json);

//   final cmsHeaderProvider = ChangeNotifierProvider<CMSPageHeader >((ref) {
//   return CMSPageHeader();
// })
// ;
}

class CMSPageBodyStyle {
  final String widgetBackgroundColor;
  final String linkTextColor;
  final String appBackGroundColor;
  final String appTextColor;
  final String primaryColor;
  final String popupBackGroundColor;
  final String errorTextColor;
  //  "PrimaryColor"
  // 			"PopupBackGroundColor"
  // 			"ErrorTextColor"
  final String tableHeaderBackGroundColor;
  final String tableHeaderTextColor;
  final String tableLineBackGroundColor;
  final String tableLineTextColor;

  CMSPageBodyStyle(
      this.widgetBackgroundColor,
      this.linkTextColor,
      this.appBackGroundColor,
      this.appTextColor,
      this.primaryColor,
      this.popupBackGroundColor,
      this.errorTextColor,
      this.tableHeaderBackGroundColor,
      this.tableHeaderTextColor,
      this.tableLineBackGroundColor,
      this.tableLineTextColor);

  Map<String, dynamic> toJson() => _$CMSPageBodyStyleToJson(this);

  factory CMSPageBodyStyle.fromJson(Map<String, dynamic> json) =>
      _$CMSPageBodyStyleFromJson(json);

//   final cmsHeaderProvider = ChangeNotifierProvider<CMSPageHeader >((ref) {
//   return CMSPageHeader();
// });
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SecondaryButtonStyle {
  final List<String> buttonColorGradient;
  final String buttonTextColor;

  SecondaryButtonStyle(this.buttonColorGradient, this.buttonTextColor);

  factory SecondaryButtonStyle.fromJson(Map<String, dynamic> json) =>
      _$SecondaryButtonStyleFromJson(json);
  Map<String, dynamic> toJson() => _$SecondaryButtonStyleToJson(this);
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

  factory CMSModulePage.fromJson(Map<String, dynamic> json) =>
      _$CMSModulePageFromJson(json);

  Color get backgroundColor {
    final temp = displayAttributes.toString().replaceAll(r'\\', '');
    final Map<String, dynamic> cleanedJson = json.decode(temp);
    final colorHex = cleanedJson['BackgroundColor'] as String;
    return HexColor.fromHex(colorHex);
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
  Map<String, dynamic> toJson() =>
      _$ModulePageItemDisplayAttributesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class CMSModuleMenu {
  @JsonKey(name: 'CMSMenusDTOList')
  final List<CMSMenu> cmsMenus;
  CMSModuleMenu(
    this.cmsMenus,
  );
  factory CMSModuleMenu.fromJson(Map<String, dynamic> json) =>
      _$CMSModuleMenuFromJson(json);
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
  factory CMSMenu.fromJson(Map<String, dynamic> json) =>
      _$CMSMenuFromJson(json);
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
  final String? targetUrl;
  final String? description;
  final int? creditType;
  final String? platform;
  CMSMenuItem(
    this.itemName,
    this.displayName,
    this.active,
    this.displayOrder,
    this.itemUrl,
    this.target,
    this.description,
    this.creditType,
    this.targetUrl,
    this.platform,
  );
  factory CMSMenuItem.fromJson(Map<String, dynamic> json) =>
      _$CMSMenuItemFromJson(json);
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
  factory CMSImages.fromJson(Map<String, dynamic> json) =>
      _$CMSImagesFromJson(json);
  Map<String, dynamic> toJson() => _$CMSImagesToJson(this);
}

class ExternalUrls {
  @JsonKey(name: 'privacy_policy')
  final String privacyPolicy;
  @JsonKey(name: 'terms_and_conditions')
  final String termsAndConditions;

  ExternalUrls(this.privacyPolicy, this.termsAndConditions);

  factory ExternalUrls.fromJson(Map<String, dynamic> json) =>
      _$ExternalUrlsFromJson(json);
  Map<String, dynamic> toJson() => _$ExternalUrlsToJson(this);
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
  factory HomePageOrder.fromJson(Map<String, dynamic> json) =>
      _$HomePageOrderFromJson(json);
  Map<String, dynamic> toJson() => _$HomePageOrderToJson(this);
}
