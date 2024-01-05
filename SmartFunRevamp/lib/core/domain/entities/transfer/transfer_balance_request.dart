import 'package:json_annotation/json_annotation.dart';
part 'transfer_balance_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransferBalanceRequest {
  int sourceAccountId;
  int destinationAccountId;
  double valueLoaded;
  String activityDate;
  String sourceAccountNumber;
  String destinationAccountNumber;
  int pOSMachineId;
  int userId;
  String entitlementType;

  TransferBalanceRequest(this.sourceAccountId,
    this.destinationAccountId,
    this.valueLoaded,
    this.activityDate,
    this.sourceAccountNumber,
    this.destinationAccountNumber,
    this.pOSMachineId,
    this.userId,
    this.entitlementType);


  factory TransferBalanceRequest.fromJson(Map<String, dynamic> json) => _$TransferBalanceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TransferBalanceRequestToJson(this);
}