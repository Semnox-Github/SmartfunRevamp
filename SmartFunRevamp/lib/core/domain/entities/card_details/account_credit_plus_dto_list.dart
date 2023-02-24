import 'package:json_annotation/json_annotation.dart';
part 'account_credit_plus_dto_list.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AccountCreditPlusDTOList {
  final String remarks;
  final DateTime? periodFrom;
  final DateTime? periodTo;
  final double creditPlus;
  final double creditPlusBalance;

  AccountCreditPlusDTOList(
    this.remarks,
    this.periodFrom,
    this.creditPlus,
    this.creditPlusBalance,
    this.periodTo,
  );

  factory AccountCreditPlusDTOList.fromJson(Map<String, dynamic> json) => _$AccountCreditPlusDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$AccountCreditPlusDTOListToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class AccountCreditPlusConsumptionDTO {
  final DateTime? fromDate;
  final DateTime? expiryDate;
  final String profileName;
  final String gameName;
  final int balanceQuantity;

  AccountCreditPlusConsumptionDTO(this.fromDate, this.expiryDate, this.profileName, this.gameName, this.balanceQuantity);
  factory AccountCreditPlusConsumptionDTO.fromJson(Map<String, dynamic> json) => _$AccountCreditPlusConsumptionDTOFromJson(json);
  Map<String, dynamic> toJson() => _$AccountCreditPlusConsumptionDTOToJson(this);
}
