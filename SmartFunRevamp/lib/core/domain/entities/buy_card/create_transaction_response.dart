import 'package:json_annotation/json_annotation.dart';
part 'create_transaction_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CreateTransactionResponse {
  int transactionId;
  int approvedBy;
  int transactionReopenedCount;
  String transactionInitiatedTime;
  int sessionId;
  String? tentNumber;
  String? guestContactEmail;
  String lockStatus;
  int lockedByPOSMachineId;
  int lockedBySiteId;
  int lockedByUserId;
  bool processedForLoyalty;
  int transactionTypeId;
  bool isActive;
  String transactionPaymentStatus;
  int transactionPaymentStatusId;
  String transactionPaymentStatusChangeDate;
  bool isNonChargeable;
  int guestCount;
  String? guestContactNumber;
  String? guestName;
  String? transactionIdentifier;
  double transactionTaxTotal;
  int? channel;
  double transactionPaymentTotal;
  String transactionDate;
  double transactionAmount;
  double transactionNetAmount;
  int userId;
  int primaryCardId;
  int orderId;
  int pOSTypeId;
  String transactionNumber;
  String transactionOTP;
  String remarks;
  int pOSMachineId;
  String pOSMachine;
  String status;
  String transactionStatus;
  int transactionStatusId;
  String transactionStatusChangeDate;
  int transactionProfileId;
  String transactionProfileName;
  String lastUpdateDate;
  String lastUpdatedBy;
  String originalSystemReference;
  int customerId;
  String externalSystemReference;
  int reprintCount;
  int originalTransactionId;
  int orderTypeGroupId;
  int provisionalBillPrintCount;
  int printCount;
  double transactionDiscountTotal;
  dynamic transactionDiscountDTOList;
  dynamic transactionPaymentDTOList;
  dynamic transactionLineDTOList;
  dynamic trxLinePaymentMappingDTOList;
  String createdBy;
  String creationDate;
  String guid;
  int siteId;
  int masterEntityId;
  bool synchStatus;
  bool isAccessible;
  bool isChanged;
  bool isChangedRecursive;

  CreateTransactionResponse(
        this.transactionId,
        this.approvedBy,
        this.transactionReopenedCount,
        this.transactionInitiatedTime,
        this.sessionId,
        this.tentNumber,
        this.guestContactEmail,
        this.lockStatus,
        this.lockedByPOSMachineId,
        this.lockedBySiteId,
        this.lockedByUserId,
        this.processedForLoyalty,
        this.transactionTypeId,
        this.isActive,
        this.transactionPaymentStatus,
        this.transactionPaymentStatusId,
        this.transactionPaymentStatusChangeDate,
        this.isNonChargeable,
        this.guestCount,
        this.guestContactNumber,
        this.guestName,
        this.transactionIdentifier,
        this.transactionTaxTotal,
        this.channel,
        this.transactionPaymentTotal,
        this.transactionDate,
        this.transactionAmount,
        this.transactionNetAmount,
        this.userId,
        this.primaryCardId,
        this.orderId,
        this.pOSTypeId,
        this.transactionNumber,
        this.transactionOTP,
        this.remarks,
        this.pOSMachineId,
        this.pOSMachine,
        this.status,
        this.transactionStatus,
        this.transactionStatusId,
        this.transactionStatusChangeDate,
        this.transactionProfileId,
        this.transactionProfileName,
        this.lastUpdateDate,
        this.lastUpdatedBy,
        this.originalSystemReference,
        this.customerId,
        this.externalSystemReference,
        this.reprintCount,
        this.originalTransactionId,
        this.orderTypeGroupId,
        this.provisionalBillPrintCount,
        this.printCount,
        this.transactionDiscountTotal,
        this.transactionDiscountDTOList,
        this.transactionPaymentDTOList,
        this.transactionLineDTOList,
        this.trxLinePaymentMappingDTOList,
        this.createdBy,
        this.creationDate,
        this.guid,
        this.siteId,
        this.masterEntityId,
        this.synchStatus,
        this.isAccessible,
        this.isChanged,
        this.isChangedRecursive);


  factory CreateTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateTransactionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CreateTransactionResponseToJson(this);
}