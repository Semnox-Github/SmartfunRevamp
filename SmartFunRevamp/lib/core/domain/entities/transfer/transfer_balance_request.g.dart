// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_balance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferBalanceRequest _$TransferBalanceRequestFromJson(
        Map<String, dynamic> json) =>
    TransferBalanceRequest(
      json['SourceAccountId'] as int,
      json['DestinationAccountId'] as int,
      (json['ValueLoaded'] as num).toDouble(),
      json['ActivityDate'] as String,
      json['SourceAccountNumber'] as String,
      json['DestinationAccountNumber'] as String,
      json['POSMachineId'] as int,
      json['UserId'] as int,
      json['EntitlementType'] as String,
    );

Map<String, dynamic> _$TransferBalanceRequestToJson(
        TransferBalanceRequest instance) =>
    <String, dynamic>{
      'SourceAccountId': instance.sourceAccountId,
      'DestinationAccountId': instance.destinationAccountId,
      'ValueLoaded': instance.valueLoaded,
      'ActivityDate': instance.activityDate,
      'SourceAccountNumber': instance.sourceAccountNumber,
      'DestinationAccountNumber': instance.destinationAccountNumber,
      'POSMachineId': instance.pOSMachineId,
      'UserId': instance.userId,
      'EntitlementType': instance.entitlementType,
    };
