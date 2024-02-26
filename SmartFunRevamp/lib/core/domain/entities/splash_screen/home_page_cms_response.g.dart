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
      json['CMSPageHeaderStyle'] == null
          ? null
          : CMSPageHeader.fromJson(
              json['CMSPageHeaderStyle'] as Map<String, dynamic>),
      json['CMSPageBodyStyle'] == null
          ? null
          : CMSPageBodyStyle.fromJson(
              json['CMSPageBodyStyle'] as Map<String, dynamic>),
      json['CMSModuleColorsHome'] == null
          ? null
          : CMSModuleColorsHome.fromJson(
              json['CMSModuleColorsHome'] as Map<String, dynamic>),
      json['CardsColor'] == null
          ? null
          : CardsColor.fromJson(json['CardsColor'] as Map<String, dynamic>),
      (json['HomePageOrder'] as List<dynamic>)
          .map((e) => HomePageOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['BuyACardFilters'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
      json['CMSButtonStyle'] == null
          ? null
          : CMSButtonStyle.fromJson(
              json['CMSButtonStyle'] as Map<String, dynamic>),
      ExternalUrls.fromJson(json['ExternalUrls'] as Map<String, dynamic>),
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
  val['ExternalUrls'] = instance.externalUrls?.toJson();
  writeNotNull('CMSModuleColorsHome', instance.cmsModuleColorsHome?.toJson());
  writeNotNull('CardsColor', instance.cardsColor?.toJson());
  val['HomePageOrder'] = instance.homePageOrder.map((e) => e.toJson()).toList();
  writeNotNull('BuyACardFilters', instance.buyACardFilters);
  writeNotNull('CMSButtonStyle', instance.buttonStyle?.toJson());
  writeNotNull('CMSPageHeaderStyle', instance.cmsPageHeader?.toJson());
  writeNotNull('CMSPageBodyStyle', instance.cmsBodyStyle?.toJson());

  return val;
}

CardsColor _$CardsColorFromJson(Map<String, dynamic> json) => CardsColor(
      json['regular'] as String?,
      json['expired'] as String?,
      json['virtual'] as String?,
      json['color_card_text'] as String?,
      (json['silver_gradient'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      (json['gold_gradient'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      (json['platinum_gradient'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
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
  writeNotNull('color_card_text', instance.colorCardText);
  writeNotNull('silver_gradient', instance.silverGradient);
  writeNotNull('gold_gradient', instance.goldGradient);
  writeNotNull('platinum_gradient', instance.platinumGradient);
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

CMSButtonStyle _$CMSButtonStyleFromJson(Map<String, dynamic> json) =>
    CMSButtonStyle(
      json['PrimaryButtonStyle'] == null
          ? null
          : PrimaryButtonStyle.fromJson(
              json['PrimaryButtonStyle'] as Map<String, dynamic>),
      json['SecondaryButtonStyle'] == null
          ? null
          : SecondaryButtonStyle.fromJson(
              json['SecondaryButtonStyle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CMSButtonStyleToJson(CMSButtonStyle instance) =>
    <String, dynamic>{
      'PrimaryButtonStyle': instance.primaryButtonStyle?.toJson(),
      'SecondaryButtonStyle': instance.secondaryButtonStyle?.toJson(),
    };

PrimaryButtonStyle _$PrimaryButtonStyleFromJson(Map<String, dynamic> json) =>
    PrimaryButtonStyle(
      (json['Button_Color_gradient'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['Button_Text_Color'] as String,
    );

Map<String, dynamic> _$PrimaryButtonStyleToJson(PrimaryButtonStyle instance) =>
    <String, dynamic>{
      'Button_Color_gradient': instance.buttonColorGradient,
      'Button_Text_Color': instance.buttonTextColor,
    };

SecondaryButtonStyle _$SecondaryButtonStyleFromJson(
        Map<String, dynamic> json) =>
    SecondaryButtonStyle(
      (json['Button_Color_gradient'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['Button_Text_Color'] as String,
    );

Map<String, dynamic> _$SecondaryButtonStyleToJson(
        SecondaryButtonStyle instance) =>
    <String, dynamic>{
      'Button_Color_gradient': instance.buttonColorGradient,
      'Button_Text_Color': instance.buttonTextColor,
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
      json['ContentName'] as String,
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
      'ContentName': instance.contentName,
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
      json['Description'] as String?,
      json['CreditType'] as int?,
      json['TargetUrl'] as String?,
      json['Platform'] as String?,
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
  writeNotNull('TargetUrl', instance.targetUrl);
  writeNotNull('Description', instance.description);
  writeNotNull('CreditType', instance.creditType);
  writeNotNull('Platform', instance.platform);
  return val;
}

CMSPageHeader _$CMSPageHeaderFromJson(Map<String, dynamic> json) =>
    CMSPageHeader(
      json['BackgroundCOlor'] as String,
      json['TextColor'] as String,
    );

Map<String, dynamic> _$CMSPageHeaderToJson(CMSPageHeader instance) {
  final val = <String, dynamic>{
    'BackgroundCOlor': instance.backgroundColor,
    'TextColor': instance.textColor,
  };

  return val;
}

CMSPageBodyStyle _$CMSPageBodyStyleFromJson(Map<String, dynamic> json) =>
    CMSPageBodyStyle(
        json['WidgetBackGroundColor'] as String,
        json['LinkTextColor'] as String,
        json['AppBackGroundColor'] as String,
        json['AppTextColor'] as String,
        json['TableHeaderBackGroundColor'] as String,
        json['TableHeaderTextColor'] as String,
        json['TableLineBackGroundColor'] as String,
        json['TableLineTextColor'] as String);

Map<String, dynamic> _$CMSPageBodyStyleToJson(CMSPageBodyStyle instance) {
  final val = <String, dynamic>{
    'WidgetBackGroundColor': instance.widgetBackgroundColor,
    'LinkTextColor': instance.linkTextColor,
    'AppBackGroundColor': instance.appBackGroundColor,
    'AppTextColor': instance.appTextColor,
    'TableHeaderBackGroundColor': instance.tableHeaderBackGroundColor,
    'TableHeaderTextColor': instance.tableHeaderTextColor,
    'TableLineBackGroundColor': instance.tableLineBackGroundColor,
    'TableLineTextColor': instance.tableHeaderTextColor
  };

  return val;
}

CMSImages _$CMSImagesFromJson(Map<String, dynamic> json) => CMSImages(
      json['splash_screen_image_path'] as String,
      json['language_pick_image_path'] as String,
      json['coupon_congrats_image_path'] as String?,
      json['reset_password_image_path'] as String?,
      json['logo_image_path'] as String?,
      json['blocked_image_path'] as String?,
      json['expired_image_path'] as String?,
      json['QR_image_path'] as String?,
      json['coin_image_path'] as String?,
      json['barcode_image_path'] as String?,
      json['no_promo_image_path'] as String?,
      json['check_ok_image_path'] as String?,
      json['bronze_image_path'] as String?,
      json['silver_image_path'] as String?,
      json['gold_image_path'] as String?,
      json['diamond_image_path'] as String?,
      json['platinum_image_path'] as String?,
      json['payment_failed_image_path'] as String?,
      json['recharge_successful_image_path'] as String?,
      json['reset_password_success_image_path'] as String?,
      json['select_location_image_path'] as String?,
      json['transfer_success_image_path'] as String?,
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
  writeNotNull('logo_image_path', instance.logoImagePath);
  writeNotNull('coupon_congrats_image_path', instance.couponCongratsImagePath);
  writeNotNull('blocked_image_path', instance.blockedImagePath);
  writeNotNull('expired_image_path', instance.expiredImagePath);
  writeNotNull('QR_image_path', instance.qrImagePath);
  writeNotNull('coin_image_path', instance.coinImagePath);
  writeNotNull('barcode_image_path', instance.barcodeImagePath);
  writeNotNull('no_promo_image_path', instance.noPromoImagePath);
  writeNotNull('check_ok_image_path', instance.checkOkImagePath);
  writeNotNull('bronze_image_path', instance.bronzeImagePath);
  writeNotNull('silver_image_path', instance.silverImagePath);
  writeNotNull('gold_image_path', instance.goldImagePath);
  writeNotNull('diamond_image_path', instance.diamondImagePath);
  writeNotNull('platinum_image_path', instance.platinumImagePath);
  writeNotNull('payment_failed_image_path', instance.paymentFailedImagePath);
  writeNotNull(
      'recharge_successful_image_path', instance.rechargeSuccessfulImagePath);
  writeNotNull('reset_password_success_image_path',
      instance.resetPasswordSuccessImagePath);
  writeNotNull('select_location_image_path', instance.selectLocationImagePath);
  writeNotNull(
      'transfer_success_image_path', instance.transferSuccessImagePath);
  return val;
}

ExternalUrls _$ExternalUrlsFromJson(Map<String, dynamic> json) => ExternalUrls(
      json['privacy_policy'] as String,
      json['terms_and_conditions'] as String,
    );

Map<String, dynamic> _$ExternalUrlsToJson(ExternalUrls instance) {
  final val = <String, dynamic>{
    'privacy_policy': instance.privacyPolicy,
    'terms_and_conditions': instance.termsAndConditions,
  };
  return val;
}

HomePageOrder _$HomePageOrderFromJson(Map<String, dynamic> json) =>
    HomePageOrder(
      json['position'] as int,
      json['widget'] as String,
      json['title'] as String,
      json['is_visible'] as bool,
      json['display_section'] as String?,
    );

Map<String, dynamic> _$HomePageOrderToJson(HomePageOrder instance) {
  final val = <String, dynamic>{
    'position': instance.position,
    'title': instance.title,
    'widget': instance.widget,
    'is_visible': instance.isVisible,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('display_section', instance.displaySection);
  return val;
}
