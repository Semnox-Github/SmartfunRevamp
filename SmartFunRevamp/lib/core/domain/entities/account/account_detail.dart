import 'package:json_annotation/json_annotation.dart';
part 'account_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class AccountDetail {
  final int accountId;
  final String tagNumber;
  final String customerName;
  final List<Object> accountCreditPlusDTOList;
  

  AccountDetail(
    this.accountId,
    this.tagNumber,
    this.customerName,
    this.accountCreditPlusDTOList,
  );
  factory AccountDetail.fromJson(Map<String, dynamic> json) => _$AccountDetailFromJson(json);
  Map<String, dynamic> toJson() => _$AccountDetailToJson(this);
}