// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_plus_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditPlusSummary _$CreditPlusSummaryFromJson(Map<String, dynamic> json) =>
    CreditPlusSummary(
      (json['CreditPlus'] as num?)?.toDouble(),
      json['CreditPlusType'] as int?,
      json['Remarks'] as String?,
      (json['CreditPlusBalance'] as num?)?.toDouble(),
      json['PeriodFrom'] == null
          ? null
          : DateTime.parse(json['PeriodFrom'] as String),
      json['PeriodTo'] == null
          ? null
          : DateTime.parse(json['PeriodTo'] as String),
      (json['AccountCreditPlusConsumptionSummaryDTOList'] as List<dynamic>?)
          ?.map((e) => AccountCreditPlusConsumptionSummaryDTOList.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreditPlusSummaryToJson(CreditPlusSummary instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CreditPlus', instance.creditPlus);
  writeNotNull('CreditPlusType', instance.creditPlusType);
  writeNotNull('Remarks', instance.remarks);
  writeNotNull('CreditPlusBalance', instance.creditPlusBalance);
  writeNotNull('PeriodFrom', instance.periodFrom?.toIso8601String());
  writeNotNull('PeriodTo', instance.periodTo?.toIso8601String());
  writeNotNull('AccountCreditPlusConsumptionSummaryDTOList',
      instance.accountCreditPlusConsumptionSummaryDTOList);
  return val;
}

AccountCreditPlusConsumptionSummaryDTOList
    _$AccountCreditPlusConsumptionSummaryDTOListFromJson(
            Map<String, dynamic> json) =>
        AccountCreditPlusConsumptionSummaryDTOList(
          json['GameProfileId'] as int?,
          json['GameProfileName'] as String?,
          json['GameId'] as int?,
          json['GameName'] as String?,
          (json['ConsumptionBalance'] as num?)?.toDouble(),
          json['CategoryId'] as int?,
          json['CategoryName'] as String?,
          json['ProductName'] as String?,
        );

Map<String, dynamic> _$AccountCreditPlusConsumptionSummaryDTOListToJson(
    AccountCreditPlusConsumptionSummaryDTOList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('GameProfileId', instance.gameProfileId);
  writeNotNull('GameProfileName', instance.gameProfileName);
  writeNotNull('GameId', instance.gameId);
  writeNotNull('GameName', instance.gameName);
  writeNotNull('ConsumptionBalance', instance.consumptionBalance);
  writeNotNull('CategoryId', instance.categoryId);
  writeNotNull('CategoryName', instance.categoryName);
  writeNotNull('ProductName', instance.productName);
  return val;
}
