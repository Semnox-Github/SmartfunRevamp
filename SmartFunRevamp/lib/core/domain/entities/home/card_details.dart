import 'package:json_annotation/json_annotation.dart';

part 'card_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CardDetails {
  int? accountId;
  String? accountNumber;
  DateTime? issueDate;
  double? faceValue;
  bool? refundFlag;
  dynamic refundAmount;
  DateTime? refundDate;
  bool? validFlag;
  int? ticketCount;
  String? notes;
  String? lastUpdatedTime;
  double? credits;
  double? courtesy;
  double? bonus;
  double? time;
  int? customerId;
  double? creditsPlayed;
  bool? ticketAllowed;
  bool? realTicketMode;
  bool? vipCustomer;
  int? siteId;
  dynamic startTime;
  dynamic lastPlayedTime;
  String? technicianCard;
  dynamic techGames;
  bool? timerResetCard;
  double? loyaltyPoints;
  String? lastUpdatedBy;
  dynamic cardTypeId;
  String? guid;
  int? uploadSiteId;
  dynamic uploadTime;
  bool? synchStatus;
  DateTime? expiryDate;
  int? downloadBatchId;
  dynamic refreshFromHqTime;
  int? masterEntityId;
  String? accountIdentifier;
  bool? primaryCard;
  String? createdBy;
  String? creationDate;
  double? balanceTime;
  double? creditPlusCardBalance;
  double? creditPlusCredits;
  double? creditPlusItemPurchase;
  double? creditPlusBonus;
  double? creditPlusTime;
  double? creditPlusTickets;
  double? creditPlusLoyaltyPoints;
  double? creditPlusRefundableBalance;
  double? redeemableCreditPlusCreditsLoyaltyPoints;
  double? creditPlusVirtualPoints;
  int? membershipId;
  String? membershipName;
  String? customerName;
  double? gamesBalance;
  double? totalCreditsBalance;
  double? totalBonusBalance;
  double? totalTimeBalance;
  double? totalCourtesyBalance;
  double? totalLoyaltyBalance;
  double? totalTicketsBalance;
  double? totalGamesBalance;
  double? totalGamePlayCreditsBalance;
  factory CardDetails.fromJson(Map<String, dynamic> json) => _$CardDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$CardDetailsToJson(this);
  CardDetails(
    this.accountId,
    this.accountNumber,
    this.issueDate,
    this.faceValue,
    this.refundFlag,
    this.refundAmount,
    this.refundDate,
    this.validFlag,
    this.ticketCount,
    this.notes,
    this.lastUpdatedTime,
    this.credits,
    this.courtesy,
    this.bonus,
    this.time,
    this.customerId,
    this.creditsPlayed,
    this.ticketAllowed,
    this.realTicketMode,
    this.vipCustomer,
    this.siteId,
    this.startTime,
    this.lastPlayedTime,
    this.technicianCard,
    this.techGames,
    this.timerResetCard,
    this.loyaltyPoints,
    this.lastUpdatedBy,
    this.cardTypeId,
    this.guid,
    this.uploadSiteId,
    this.uploadTime,
    this.synchStatus,
    this.expiryDate,
    this.downloadBatchId,
    this.refreshFromHqTime,
    this.masterEntityId,
    this.accountIdentifier,
    this.primaryCard,
    this.createdBy,
    this.creationDate,
    this.balanceTime,
    this.creditPlusCardBalance,
    this.creditPlusCredits,
    this.creditPlusItemPurchase,
    this.creditPlusBonus,
    this.creditPlusTime,
    this.creditPlusTickets,
    this.creditPlusLoyaltyPoints,
    this.creditPlusRefundableBalance,
    this.redeemableCreditPlusCreditsLoyaltyPoints,
    this.creditPlusVirtualPoints,
    this.membershipId,
    this.membershipName,
    this.customerName,
    this.gamesBalance,
    this.totalCreditsBalance,
    this.totalBonusBalance,
    this.totalTimeBalance,
    this.totalCourtesyBalance,
    this.totalLoyaltyBalance,
    this.totalTicketsBalance,
    this.totalGamesBalance,
    this.totalGamePlayCreditsBalance,
  );
}
