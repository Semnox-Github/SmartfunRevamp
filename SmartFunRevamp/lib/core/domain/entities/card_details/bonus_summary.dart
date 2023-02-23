import 'package:json_annotation/json_annotation.dart';
part 'bonus_summary.g.dart';

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
