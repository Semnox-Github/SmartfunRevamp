import 'package:json_annotation/json_annotation.dart';
import 'package:semnox/core/domain/entities/card_details/account_credit_plus_dto_list.dart';

import 'account_game_dto_list.dart';
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
  @JsonKey(defaultValue: 0.0)
  double? loyaltyPoints;
  String? lastUpdatedBy;
  dynamic cardTypeId;
  String? guid;
  int? uploadSiteId;
  dynamic uploadTime;
  bool? synchStatus;
  String? expiryDate;
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
  List<AccountCreditPlusDTOList>? accountCreditPlusDTOList;
  List<AccountGameDTOList>? accountGameDTOList;

  CardDetails({
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
  });
  factory CardDetails.fromJson(Map<String, dynamic> json) =>
      _$CardDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$CardDetailsToJson(this);

  bool isBlocked() {
    if (accountNumber!.startsWith('T')) {
      return true;
    }
    return false;
  }

  bool isExpired() {
    final today = DateTime.now();
    final DateTime expirationDate =
        expiryDate != null ? DateTime.parse(expiryDate.toString()) : today;
    final int daysUntilExpiration =
        (expirationDate.difference(today).inHours / 24).round();
    if (daysUntilExpiration < 0) {
      return true;
    }
    return false;
  }

  bool isSameCard(CardDetails? cardTo) {
    if (cardTo == null) {
      return false;
    }
    return accountNumber == cardTo.accountNumber;
  }

  String pointsBasedOnCreditType(int creditType) {
    switch (creditType) {
      case 0:
        return totalGamePlayCreditsBalance?.toStringAsFixed(0) ?? '';
      case 1:
        return totalLoyaltyBalance?.toStringAsFixed(0) ?? '';
      case 2:
        return totalTicketsBalance?.toStringAsFixed(0) ?? '';
      case 5:
        return totalBonusBalance?.toStringAsFixed(0) ?? '';
      case 6:
        return totalTimeBalance?.toStringAsFixed(0) ?? '';
      default:
        return '0';
    }
  }
}
