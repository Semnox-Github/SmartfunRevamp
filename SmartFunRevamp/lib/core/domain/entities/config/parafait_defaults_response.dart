import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
part 'parafait_defaults_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class ParafaitDefaultsResponse {
  static const String passwordKey = 'ENABLE_PASSWORD_ON_SMARTFUN';
  static const String cardCoachMark = "CARD_COACH_MARK";
  static const String enableDiscounts = "ENABLE_DISCOUNTS_IN_POS";
  static const String onlineRechargeEnabledKey =
      'ALLOW_ONLINE_RECHARGE_LOCATION_OVERIDE';
  static const String currencySymbol = 'CURRENCY_SYMBOL';
  static const String currencyFormat = 'AMOUNT_FORMAT';
  static const String virtualStoreSiteId = "VIRTUAL_STORE_SITE_ID";
  static const String playStoreUrl = "PLAY_STORE_URL";
  static const String appStoreUrl = "APP_STORE_URL";
  static const String customerAppThemeNo = "CUSTOMERAPP_THEME_NO";
  //static const String applyDiscount = "ONLINE_DISCOUNT_APPLY_ALLOWED";
  @JsonKey(name: 'ParafaitDefaultContainerDTOList')
  final List<ParafaitDefault> parafaitsDefaults;

  ParafaitDefaultsResponse(this.parafaitsDefaults);
  factory ParafaitDefaultsResponse.fromJson(Map<String, dynamic> json) =>
      _$ParafaitDefaultsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ParafaitDefaultsResponseToJson(this);

  String? getDefault(String key) {
    final parafaitDefault = parafaitsDefaults
        .firstWhereOrNull((element) => element.defaultValueName == key);
    return parafaitDefault?.defaultValue;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class ParafaitDefault {
  final String defaultValueName;
  final String defaultValue;

  ParafaitDefault(this.defaultValueName, this.defaultValue);
  factory ParafaitDefault.fromJson(Map<String, dynamic> json) =>
      _$ParafaitDefaultFromJson(json);
  Map<String, dynamic> toJson() => _$ParafaitDefaultToJson(this);
}
