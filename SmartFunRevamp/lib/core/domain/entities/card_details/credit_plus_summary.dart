import 'package:json_annotation/json_annotation.dart';
part 'credit_plus_summary.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CreditPlusSummary {
  double? creditPlus;
  int? creditPlusType;
  String? remarks;
  double? creditPlusBalance;
  DateTime? periodFrom;
  DateTime? periodTo;
  List<AccountCreditPlusConsumptionSummaryDTOList>?
  accountCreditPlusConsumptionSummaryDTOList;

  CreditPlusSummary(this.creditPlus,
    this.creditPlusType,
    this.remarks,
    this.creditPlusBalance,
    this.periodFrom,
    this.periodTo,
    this.accountCreditPlusConsumptionSummaryDTOList);

  factory CreditPlusSummary.fromJson(Map<String, dynamic> json) =>
      _$CreditPlusSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$CreditPlusSummaryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class AccountCreditPlusConsumptionSummaryDTOList {
  int? gameProfileId;
  String? gameProfileName;
  int? gameId;
  String? gameName;
  double? consumptionBalance;
  int? categoryId;
  String? categoryName;
  String? productName;

  AccountCreditPlusConsumptionSummaryDTOList(
    this.gameProfileId,
    this.gameProfileName,
    this.gameId,
    this.gameName,
    this.consumptionBalance,
    this.categoryId,
    this.categoryName,
    this.productName
      );

  factory AccountCreditPlusConsumptionSummaryDTOList.fromJson(Map<String, dynamic> json) =>
      _$AccountCreditPlusConsumptionSummaryDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$AccountCreditPlusConsumptionSummaryDTOListToJson(this);
}