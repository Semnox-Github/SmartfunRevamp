import 'package:json_annotation/json_annotation.dart';
part 'app_config_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AppConfigResponse {
  @JsonKey(name: 'GoogleRegistration')
  final bool isGoogleRegistrationEnabled;
  @JsonKey(name: 'FbRegistration')
  final bool isFBRegistrationEnabled;
  @JsonKey(name: 'PromotionLayout')
  final bool showPromotionLayout;
  @JsonKey(name: 'TopGameLayout')
  final bool showTopGameLayout;
  @JsonKey(name: 'TopEventLayout')
  final bool showTopEventLayout;
  final bool enableNewCard;
  final bool enableLinkCard;
  final bool enableRedeemCard;
  final bool enableRechargeCard;
  final bool enableTransferCredits;
  final bool enableLostCard;
  final int idleTimeout;
  final int hQRefreshThreshold;
  final int appValidityCheckDelay;
  final String currencyCode;
  final bool showCreditsOnCard;
  final bool showBonusOnCard;
  final bool showTimeOnCard;
  final bool showTicketsOnCard;
  final bool showLoyaltyOnCard;
  final bool showCourtesyOnCard;
  final List<CustomLinks> customLinks;
  final bool enableVirtualSite;
  final int virtualSiteId;
  final bool enableGamePlay;
  final String playBoxLink;
  final bool enableMembership;
  final String numberFormat;
  final String promoImageFolderURL;
  final int ageOfMajority;
  final int defaultLanguage;
  final bool waiverDeactivationNeedsManagerApproval;
  final bool waiverCodeIsMandatoryToFetchCustomer;
  final bool checkWaiverRegistrationCountForTransaction;
  final bool otpCheckRequiredForWaiverRegistration;
  final int validityPeriodForWaiverRegistrationOTP;
  final bool enableWaiverSignInKiosk;
  final bool waiverOverrideNeedsManagerApproval;
  final bool allowWaiverOverride;
  final bool overrideSiteForTransaction;
  final String? waiverSetSelectionOptions;
  final bool showCustomAttributesOnWaiver;
  final String? promotionLayoutURL;
  final bool socialLayout;
  final bool storeLocatorLayout;
  final String? storeLocatorURL;
  final bool showCardExpiry;
  final bool showCardIssued;
  final String? supportContactNumber;
  final String? supportEmail;
  final String? supportMessageText;
  @JsonKey(name: 'CMSSocialLinksDTO')
  final List<CMSSocialLinksDTO> cmsSocialLinksDTO;

  AppConfigResponse(
    this.isGoogleRegistrationEnabled,
    this.isFBRegistrationEnabled,
    this.showPromotionLayout,
    this.showTopGameLayout,
    this.showTopEventLayout,
    this.enableNewCard,
    this.enableLinkCard,
    this.enableRedeemCard,
    this.enableRechargeCard,
    this.enableTransferCredits,
    this.enableLostCard,
    this.idleTimeout,
    this.hQRefreshThreshold,
    this.appValidityCheckDelay,
    this.currencyCode,
    this.showCreditsOnCard,
    this.showBonusOnCard,
    this.showTimeOnCard,
    this.showTicketsOnCard,
    this.showLoyaltyOnCard,
    this.showCourtesyOnCard,
    this.customLinks,
    this.enableVirtualSite,
    this.virtualSiteId,
    this.enableGamePlay,
    this.playBoxLink,
    this.enableMembership,
    this.numberFormat,
    this.promoImageFolderURL,
    this.ageOfMajority,
    this.defaultLanguage,
    this.waiverDeactivationNeedsManagerApproval,
    this.waiverCodeIsMandatoryToFetchCustomer,
    this.checkWaiverRegistrationCountForTransaction,
    this.otpCheckRequiredForWaiverRegistration,
    this.validityPeriodForWaiverRegistrationOTP,
    this.enableWaiverSignInKiosk,
    this.waiverOverrideNeedsManagerApproval,
    this.allowWaiverOverride,
    this.overrideSiteForTransaction,
    this.waiverSetSelectionOptions,
    this.showCustomAttributesOnWaiver,
    this.promotionLayoutURL,
    this.socialLayout,
    this.storeLocatorLayout,
    this.storeLocatorURL,
    this.showCardExpiry,
    this.showCardIssued,
    this.supportContactNumber,
    this.supportEmail,
    this.supportMessageText,
    this.cmsSocialLinksDTO,
  );
  factory AppConfigResponse.fromJson(Map<String, dynamic> json) => _$AppConfigResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AppConfigResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CustomLinks {
  final int lookupValueId;
  final int lookupId;
  final String lookupName;
  final String lookupValue;
  final String description;

  CustomLinks(
    this.lookupValueId,
    this.lookupId,
    this.lookupName,
    this.lookupValue,
    this.description,
  );
  factory CustomLinks.fromJson(Map<String, dynamic> json) => _$CustomLinksFromJson(json);
  Map<String, dynamic> toJson() => _$CustomLinksToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class CMSSocialLinksDTO {
  final int socialLinkId;
  final String linkName;
  final String url;
  @JsonKey(name: 'Active')
  final bool isActive;
  final String imagePath;

  CMSSocialLinksDTO(
    this.socialLinkId,
    this.linkName,
    this.url,
    this.isActive,
    this.imagePath,
  );
  factory CMSSocialLinksDTO.fromJson(Map<String, dynamic> json) => _$CMSSocialLinksDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CMSSocialLinksDTOToJson(this);
}
