// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_credit_plus_dto_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountCreditPlusDTOList _$AccountCreditPlusDTOListFromJson(
        Map<String, dynamic> json) =>
    AccountCreditPlusDTOList(
      json['Remarks'] as String,
      json['PeriodFrom'] == null
          ? null
          : DateTime.parse(json['PeriodFrom'] as String),
      (json['CreditPlus'] as num).toDouble(),
      (json['CreditPlusBalance'] as num).toDouble(),
      json['PeriodTo'] == null
          ? null
          : DateTime.parse(json['PeriodTo'] as String),
      json['CreditPlusType'] as int,
    );

Map<String, dynamic> _$AccountCreditPlusDTOListToJson(
    AccountCreditPlusDTOList instance) {
  final val = <String, dynamic>{
    'Remarks': instance.remarks,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PeriodFrom', instance.periodFrom?.toIso8601String());
  writeNotNull('PeriodTo', instance.periodTo?.toIso8601String());
  val['CreditPlus'] = instance.creditPlus;
  val['CreditPlusBalance'] = instance.creditPlusBalance;
  val['CreditPlusType'] = instance.creditPlusType;
  return val;
}

AccountCreditPlusConsumptionDTO _$AccountCreditPlusConsumptionDTOFromJson(
        Map<String, dynamic> json) =>
    AccountCreditPlusConsumptionDTO(
      json['FromDate'] == null
          ? null
          : DateTime.parse(json['FromDate'] as String),
      json['ExpiryDate'] == null
          ? null
          : DateTime.parse(json['ExpiryDate'] as String),
      json['ProfileName'] as String,
      json['GameName'] as String,
      json['BalanceQuantity'] as int,
    );

Map<String, dynamic> _$AccountCreditPlusConsumptionDTOToJson(
    AccountCreditPlusConsumptionDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('FromDate', instance.fromDate?.toIso8601String());
  writeNotNull('ExpiryDate', instance.expiryDate?.toIso8601String());
  val['ProfileName'] = instance.profileName;
  val['GameName'] = instance.gameName;
  val['BalanceQuantity'] = instance.balanceQuantity;
  return val;
}
