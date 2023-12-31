// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfigResponse _$AppConfigResponseFromJson(Map<String, dynamic> json) =>
    AppConfigResponse(
      json['GoogleRegistration'] as bool?,
      json['FbRegistration'] as bool?,
      json['PromotionLayout'] as bool?,
      json['TopGameLayout'] as bool?,
      json['TopEventLayout'] as bool?,
      json['EnableNewCard'] as bool?,
      json['EnableLinkCard'] as bool?,
      json['EnableRedeemCard'] as bool?,
      json['EnableRechargeCard'] as bool?,
      json['EnableTransferCredits'] as bool?,
      json['EnableLostCard'] as bool?,
      json['IdleTimeout'] as int?,
      json['HQRefreshThreshold'] as int?,
      json['AppValidityCheckDelay'] as int?,
      json['CurrencyCode'] as String?,
      json['ShowCreditsOnCard'] as bool?,
      json['ShowBonusOnCard'] as bool?,
      json['ShowTimeOnCard'] as bool?,
      json['ShowTicketsOnCard'] as bool?,
      json['ShowLoyaltyOnCard'] as bool?,
      json['ShowCourtesyOnCard'] as bool?,
      (json['CustomLinks'] as List<dynamic>?)
          ?.map((e) => CustomLinks.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['EnableVirtualSite'] as bool?,
      json['VirtualSiteId'] as int?,
      json['EnableGamePlay'] as bool?,
      json['PlayBoxLink'] as String?,
      json['EnableMembership'] as bool?,
      json['NumberFormat'] as String?,
      json['PromoImageFolderURL'] as String?,
      json['AgeOfMajority'] as int?,
      json['DefaultLanguage'] as int?,
      json['WaiverDeactivationNeedsManagerApproval'] as bool?,
      json['WaiverCodeIsMandatoryToFetchCustomer'] as bool?,
      json['CheckWaiverRegistrationCountForTransaction'] as bool?,
      json['OtpCheckRequiredForWaiverRegistration'] as bool?,
      json['ValidityPeriodForWaiverRegistrationOTP'] as int?,
      json['EnableWaiverSignInKiosk'] as bool?,
      json['WaiverOverrideNeedsManagerApproval'] as bool?,
      json['AllowWaiverOverride'] as bool?,
      json['OverrideSiteForTransaction'] as bool?,
      json['WaiverSetSelectionOptions'] as String?,
      json['ShowCustomAttributesOnWaiver'] as bool?,
      json['PromotionLayoutURL'] as String?,
      json['SocialLayout'] as bool? ?? false,
      json['StoreLocatorLayout'] as bool?,
      json['StoreLocatorURL'] as String?,
      json['ShowCardExpiry'] as bool?,
      json['ShowCardIssued'] as bool?,
      json['SupportContactNumber'] as String?,
      json['SupportEmail'] as String?,
      json['SupportMessageText'] as String?,
      (json['CMSSocialLinksDTO'] as List<dynamic>?)
          ?.map((e) => CMSSocialLinksDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppConfigResponseToJson(AppConfigResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('GoogleRegistration', instance.isGoogleRegistrationEnabled);
  writeNotNull('FbRegistration', instance.isFBRegistrationEnabled);
  writeNotNull('PromotionLayout', instance.showPromotionLayout);
  writeNotNull('TopGameLayout', instance.showTopGameLayout);
  writeNotNull('TopEventLayout', instance.showTopEventLayout);
  writeNotNull('EnableNewCard', instance.enableNewCard);
  writeNotNull('EnableLinkCard', instance.enableLinkCard);
  writeNotNull('EnableRedeemCard', instance.enableRedeemCard);
  writeNotNull('EnableRechargeCard', instance.enableRechargeCard);
  writeNotNull('EnableTransferCredits', instance.enableTransferCredits);
  writeNotNull('EnableLostCard', instance.enableLostCard);
  writeNotNull('IdleTimeout', instance.idleTimeout);
  writeNotNull('HQRefreshThreshold', instance.hQRefreshThreshold);
  writeNotNull('AppValidityCheckDelay', instance.appValidityCheckDelay);
  writeNotNull('CurrencyCode', instance.currencyCode);
  writeNotNull('ShowCreditsOnCard', instance.showCreditsOnCard);
  writeNotNull('ShowBonusOnCard', instance.showBonusOnCard);
  writeNotNull('ShowTimeOnCard', instance.showTimeOnCard);
  writeNotNull('ShowTicketsOnCard', instance.showTicketsOnCard);
  writeNotNull('ShowLoyaltyOnCard', instance.showLoyaltyOnCard);
  writeNotNull('ShowCourtesyOnCard', instance.showCourtesyOnCard);
  writeNotNull('CustomLinks', instance.customLinks);
  writeNotNull('EnableVirtualSite', instance.enableVirtualSite);
  writeNotNull('VirtualSiteId', instance.virtualSiteId);
  writeNotNull('EnableGamePlay', instance.enableGamePlay);
  writeNotNull('PlayBoxLink', instance.playBoxLink);
  writeNotNull('EnableMembership', instance.enableMembership);
  writeNotNull('NumberFormat', instance.numberFormat);
  writeNotNull('PromoImageFolderURL', instance.promoImageFolderURL);
  writeNotNull('AgeOfMajority', instance.ageOfMajority);
  writeNotNull('DefaultLanguage', instance.defaultLanguage);
  writeNotNull('WaiverDeactivationNeedsManagerApproval',
      instance.waiverDeactivationNeedsManagerApproval);
  writeNotNull('WaiverCodeIsMandatoryToFetchCustomer',
      instance.waiverCodeIsMandatoryToFetchCustomer);
  writeNotNull('CheckWaiverRegistrationCountForTransaction',
      instance.checkWaiverRegistrationCountForTransaction);
  writeNotNull('OtpCheckRequiredForWaiverRegistration',
      instance.otpCheckRequiredForWaiverRegistration);
  writeNotNull('ValidityPeriodForWaiverRegistrationOTP',
      instance.validityPeriodForWaiverRegistrationOTP);
  writeNotNull('EnableWaiverSignInKiosk', instance.enableWaiverSignInKiosk);
  writeNotNull('WaiverOverrideNeedsManagerApproval',
      instance.waiverOverrideNeedsManagerApproval);
  writeNotNull('AllowWaiverOverride', instance.allowWaiverOverride);
  writeNotNull(
      'OverrideSiteForTransaction', instance.overrideSiteForTransaction);
  writeNotNull('WaiverSetSelectionOptions', instance.waiverSetSelectionOptions);
  writeNotNull(
      'ShowCustomAttributesOnWaiver', instance.showCustomAttributesOnWaiver);
  writeNotNull('PromotionLayoutURL', instance.promotionLayoutURL);
  val['SocialLayout'] = instance.socialLayout;
  writeNotNull('StoreLocatorLayout', instance.storeLocatorLayout);
  writeNotNull('StoreLocatorURL', instance.storeLocatorURL);
  writeNotNull('ShowCardExpiry', instance.showCardExpiry);
  writeNotNull('ShowCardIssued', instance.showCardIssued);
  writeNotNull('SupportContactNumber', instance.supportContactNumber);
  writeNotNull('SupportEmail', instance.supportEmail);
  writeNotNull('SupportMessageText', instance.supportMessageText);
  writeNotNull('CMSSocialLinksDTO', instance.cmsSocialLinksDTO);
  return val;
}

CustomLinks _$CustomLinksFromJson(Map<String, dynamic> json) => CustomLinks(
      json['LookupValueId'] as int,
      json['LookupId'] as int,
      json['LookupName'] as String,
      json['LookupValue'] as String,
      json['Description'] as String,
    );

Map<String, dynamic> _$CustomLinksToJson(CustomLinks instance) =>
    <String, dynamic>{
      'LookupValueId': instance.lookupValueId,
      'LookupId': instance.lookupId,
      'LookupName': instance.lookupName,
      'LookupValue': instance.lookupValue,
      'Description': instance.description,
    };

CMSSocialLinksDTO _$CMSSocialLinksDTOFromJson(Map<String, dynamic> json) =>
    CMSSocialLinksDTO(
      json['SocialLinkId'] as int,
      json['LinkName'] as String,
      json['Url'] as String,
      json['Active'] as bool,
      json['ImagePath'] as String,
    );

Map<String, dynamic> _$CMSSocialLinksDTOToJson(CMSSocialLinksDTO instance) =>
    <String, dynamic>{
      'SocialLinkId': instance.socialLinkId,
      'LinkName': instance.linkName,
      'Url': instance.url,
      'Active': instance.isActive,
      'ImagePath': instance.imagePath,
    };
