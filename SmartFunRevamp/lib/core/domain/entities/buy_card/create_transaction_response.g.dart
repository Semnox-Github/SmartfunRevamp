// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTransactionResponse _$CreateTransactionResponseFromJson(
        Map<String, dynamic> json) =>
    CreateTransactionResponse(
      json['TransactionId'] as int,
      json['ApprovedBy'] as int,
      json['TransactionReopenedCount'] as int,
      json['TransactionInitiatedTime'] as String,
      json['SessionId'] as int,
      json['TentNumber'] as String?,
      json['GuestContactEmail'] as String?,
      json['LockStatus'] as String,
      json['LockedByPOSMachineId'] as int,
      json['LockedBySiteId'] as int,
      json['LockedByUserId'] as int,
      json['ProcessedForLoyalty'] as bool,
      json['TransactionTypeId'] as int,
      json['IsActive'] as bool,
      json['TransactionPaymentStatus'] as String,
      json['TransactionPaymentStatusId'] as int,
      json['TransactionPaymentStatusChangeDate'] as String,
      json['IsNonChargeable'] as bool,
      json['GuestCount'] as int,
      json['GuestContactNumber'] as String?,
      json['GuestName'] as String?,
      json['TransactionIdentifier'] as String?,
      (json['TransactionTaxTotal'] as num).toDouble(),
      json['Channel'] as int?,
      (json['TransactionPaymentTotal'] as num).toDouble(),
      json['TransactionDate'] as String,
      (json['TransactionAmount'] as num).toDouble(),
      (json['TransactionNetAmount'] as num).toDouble(),
      json['UserId'] as int,
      json['PrimaryCardId'] as int,
      json['OrderId'] as int,
      json['POSTypeId'] as int,
      json['TransactionNumber'] as String,
      json['TransactionOTP'] as String,
      json['Remarks'] as String,
      json['POSMachineId'] as int,
      json['POSMachine'] as String,
      json['Status'] as String,
      json['TransactionStatus'] as String,
      json['TransactionStatusId'] as int,
      json['TransactionStatusChangeDate'] as String,
      json['TransactionProfileId'] as int,
      json['TransactionProfileName'] as String,
      json['LastUpdateDate'] as String,
      json['LastUpdatedBy'] as String,
      json['OriginalSystemReference'] as String,
      json['CustomerId'] as int,
      json['ExternalSystemReference'] as String,
      json['ReprintCount'] as int,
      json['OriginalTransactionId'] as int,
      json['OrderTypeGroupId'] as int,
      json['ProvisionalBillPrintCount'] as int,
      json['PrintCount'] as int,
      (json['TransactionDiscountTotal'] as num).toDouble(),
      json['TransactionDiscountDTOList'],
      json['TransactionPaymentDTOList'],
      json['TransactionLineDTOList'],
      json['TrxLinePaymentMappingDTOList'],
      json['CreatedBy'] as String,
      json['CreationDate'] as String,
      json['Guid'] as String,
      json['SiteId'] as int,
      json['MasterEntityId'] as int,
      json['SynchStatus'] as bool,
      json['IsAccessible'] as bool,
      json['IsChanged'] as bool,
      json['IsChangedRecursive'] as bool,
    );

Map<String, dynamic> _$CreateTransactionResponseToJson(
    CreateTransactionResponse instance) {
  final val = <String, dynamic>{
    'TransactionId': instance.transactionId,
    'ApprovedBy': instance.approvedBy,
    'TransactionReopenedCount': instance.transactionReopenedCount,
    'TransactionInitiatedTime': instance.transactionInitiatedTime,
    'SessionId': instance.sessionId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('TentNumber', instance.tentNumber);
  writeNotNull('GuestContactEmail', instance.guestContactEmail);
  val['LockStatus'] = instance.lockStatus;
  val['LockedByPOSMachineId'] = instance.lockedByPOSMachineId;
  val['LockedBySiteId'] = instance.lockedBySiteId;
  val['LockedByUserId'] = instance.lockedByUserId;
  val['ProcessedForLoyalty'] = instance.processedForLoyalty;
  val['TransactionTypeId'] = instance.transactionTypeId;
  val['IsActive'] = instance.isActive;
  val['TransactionPaymentStatus'] = instance.transactionPaymentStatus;
  val['TransactionPaymentStatusId'] = instance.transactionPaymentStatusId;
  val['TransactionPaymentStatusChangeDate'] =
      instance.transactionPaymentStatusChangeDate;
  val['IsNonChargeable'] = instance.isNonChargeable;
  val['GuestCount'] = instance.guestCount;
  writeNotNull('GuestContactNumber', instance.guestContactNumber);
  writeNotNull('GuestName', instance.guestName);
  writeNotNull('TransactionIdentifier', instance.transactionIdentifier);
  val['TransactionTaxTotal'] = instance.transactionTaxTotal;
  writeNotNull('Channel', instance.channel);
  val['TransactionPaymentTotal'] = instance.transactionPaymentTotal;
  val['TransactionDate'] = instance.transactionDate;
  val['TransactionAmount'] = instance.transactionAmount;
  val['TransactionNetAmount'] = instance.transactionNetAmount;
  val['UserId'] = instance.userId;
  val['PrimaryCardId'] = instance.primaryCardId;
  val['OrderId'] = instance.orderId;
  val['POSTypeId'] = instance.pOSTypeId;
  val['TransactionNumber'] = instance.transactionNumber;
  val['TransactionOTP'] = instance.transactionOTP;
  val['Remarks'] = instance.remarks;
  val['POSMachineId'] = instance.pOSMachineId;
  val['POSMachine'] = instance.pOSMachine;
  val['Status'] = instance.status;
  val['TransactionStatus'] = instance.transactionStatus;
  val['TransactionStatusId'] = instance.transactionStatusId;
  val['TransactionStatusChangeDate'] = instance.transactionStatusChangeDate;
  val['TransactionProfileId'] = instance.transactionProfileId;
  val['TransactionProfileName'] = instance.transactionProfileName;
  val['LastUpdateDate'] = instance.lastUpdateDate;
  val['LastUpdatedBy'] = instance.lastUpdatedBy;
  val['OriginalSystemReference'] = instance.originalSystemReference;
  val['CustomerId'] = instance.customerId;
  val['ExternalSystemReference'] = instance.externalSystemReference;
  val['ReprintCount'] = instance.reprintCount;
  val['OriginalTransactionId'] = instance.originalTransactionId;
  val['OrderTypeGroupId'] = instance.orderTypeGroupId;
  val['ProvisionalBillPrintCount'] = instance.provisionalBillPrintCount;
  val['PrintCount'] = instance.printCount;
  val['TransactionDiscountTotal'] = instance.transactionDiscountTotal;
  writeNotNull(
      'TransactionDiscountDTOList', instance.transactionDiscountDTOList);
  writeNotNull('TransactionPaymentDTOList', instance.transactionPaymentDTOList);
  writeNotNull('TransactionLineDTOList', instance.transactionLineDTOList);
  writeNotNull(
      'TrxLinePaymentMappingDTOList', instance.trxLinePaymentMappingDTOList);
  val['CreatedBy'] = instance.createdBy;
  val['CreationDate'] = instance.creationDate;
  val['Guid'] = instance.guid;
  val['SiteId'] = instance.siteId;
  val['MasterEntityId'] = instance.masterEntityId;
  val['SynchStatus'] = instance.synchStatus;
  val['IsAccessible'] = instance.isAccessible;
  val['IsChanged'] = instance.isChanged;
  val['IsChangedRecursive'] = instance.isChangedRecursive;
  return val;
}
