// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardDetails _$CardDetailsFromJson(Map<String, dynamic> json) => CardDetails(
      accountId: json['AccountId'] as int?,
      accountNumber: json['AccountNumber'] as String?,
      issueDate: json['IssueDate'] == null
          ? null
          : DateTime.parse(json['IssueDate'] as String),
      faceValue: (json['FaceValue'] as num?)?.toDouble(),
      refundFlag: json['RefundFlag'] as bool?,
      refundAmount: json['RefundAmount'],
      refundDate: json['RefundDate'] == null
          ? null
          : DateTime.parse(json['RefundDate'] as String),
      validFlag: json['ValidFlag'] as bool?,
      ticketCount: json['TicketCount'] as int?,
      notes: json['Notes'] as String?,
      lastUpdatedTime: json['LastUpdatedTime'] as String?,
      credits: (json['Credits'] as num?)?.toDouble(),
      courtesy: (json['Courtesy'] as num?)?.toDouble(),
      bonus: (json['Bonus'] as num?)?.toDouble(),
      time: (json['Time'] as num?)?.toDouble(),
      customerId: json['CustomerId'] as int?,
      creditsPlayed: (json['CreditsPlayed'] as num?)?.toDouble(),
      ticketAllowed: json['TicketAllowed'] as bool?,
      realTicketMode: json['RealTicketMode'] as bool?,
      vipCustomer: json['VipCustomer'] as bool?,
      siteId: json['SiteId'] as int?,
      startTime: json['StartTime'],
      lastPlayedTime: json['LastPlayedTime'],
      technicianCard: json['TechnicianCard'] as String?,
      techGames: json['TechGames'],
      timerResetCard: json['TimerResetCard'] as bool?,
      loyaltyPoints: (json['LoyaltyPoints'] as num?)?.toDouble() ?? 0.0,
      lastUpdatedBy: json['LastUpdatedBy'] as String?,
      cardTypeId: json['CardTypeId'],
      guid: json['Guid'] as String?,
      uploadSiteId: json['UploadSiteId'] as int?,
      uploadTime: json['UploadTime'],
      synchStatus: json['SynchStatus'] as bool?,
      expiryDate: json['ExpiryDate'] as String?,
      downloadBatchId: json['DownloadBatchId'] as int?,
      refreshFromHqTime: json['RefreshFromHqTime'],
      masterEntityId: json['MasterEntityId'] as int?,
      accountIdentifier: json['AccountIdentifier'] as String?,
      primaryCard: json['PrimaryCard'] as bool?,
      createdBy: json['CreatedBy'] as String?,
      creationDate: json['CreationDate'] as String?,
      balanceTime: (json['BalanceTime'] as num?)?.toDouble(),
      creditPlusCardBalance:
          (json['CreditPlusCardBalance'] as num?)?.toDouble(),
      creditPlusCredits: (json['CreditPlusCredits'] as num?)?.toDouble(),
      creditPlusItemPurchase:
          (json['CreditPlusItemPurchase'] as num?)?.toDouble(),
      creditPlusBonus: (json['CreditPlusBonus'] as num?)?.toDouble(),
      creditPlusTime: (json['CreditPlusTime'] as num?)?.toDouble(),
      creditPlusTickets: (json['CreditPlusTickets'] as num?)?.toDouble(),
      creditPlusLoyaltyPoints:
          (json['CreditPlusLoyaltyPoints'] as num?)?.toDouble(),
      creditPlusRefundableBalance:
          (json['CreditPlusRefundableBalance'] as num?)?.toDouble(),
      redeemableCreditPlusCreditsLoyaltyPoints:
          (json['RedeemableCreditPlusCreditsLoyaltyPoints'] as num?)
              ?.toDouble(),
      creditPlusVirtualPoints:
          (json['CreditPlusVirtualPoints'] as num?)?.toDouble(),
      membershipId: json['MembershipId'] as int?,
      membershipName: json['MembershipName'] as String?,
      customerName: json['CustomerName'] as String?,
      gamesBalance: (json['GamesBalance'] as num?)?.toDouble(),
      totalCreditsBalance: (json['TotalCreditsBalance'] as num?)?.toDouble(),
      totalBonusBalance: (json['TotalBonusBalance'] as num?)?.toDouble(),
      totalTimeBalance: (json['TotalTimeBalance'] as num?)?.toDouble(),
      totalCourtesyBalance: (json['TotalCourtesyBalance'] as num?)?.toDouble(),
      totalLoyaltyBalance: (json['TotalLoyaltyBalance'] as num?)?.toDouble(),
      totalTicketsBalance: (json['TotalTicketsBalance'] as num?)?.toDouble(),
      totalGamesBalance: (json['TotalGamesBalance'] as num?)?.toDouble(),
      totalGamePlayCreditsBalance:
          (json['TotalGamePlayCreditsBalance'] as num?)?.toDouble(),
    )
      ..accountCreditPlusDTOList =
          (json['AccountCreditPlusDTOList'] as List<dynamic>?)
              ?.map((e) =>
                  AccountCreditPlusDTOList.fromJson(e as Map<String, dynamic>))
              .toList()
      ..accountGameDTOList = (json['AccountGameDTOList'] as List<dynamic>?)
          ?.map((e) => AccountGameDTOList.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CardDetailsToJson(CardDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AccountId', instance.accountId);
  writeNotNull('AccountNumber', instance.accountNumber);
  writeNotNull('IssueDate', instance.issueDate?.toIso8601String());
  writeNotNull('FaceValue', instance.faceValue);
  writeNotNull('RefundFlag', instance.refundFlag);
  writeNotNull('RefundAmount', instance.refundAmount);
  writeNotNull('RefundDate', instance.refundDate?.toIso8601String());
  writeNotNull('ValidFlag', instance.validFlag);
  writeNotNull('TicketCount', instance.ticketCount);
  writeNotNull('Notes', instance.notes);
  writeNotNull('LastUpdatedTime', instance.lastUpdatedTime);
  writeNotNull('Credits', instance.credits);
  writeNotNull('Courtesy', instance.courtesy);
  writeNotNull('Bonus', instance.bonus);
  writeNotNull('Time', instance.time);
  writeNotNull('CustomerId', instance.customerId);
  writeNotNull('CreditsPlayed', instance.creditsPlayed);
  writeNotNull('TicketAllowed', instance.ticketAllowed);
  writeNotNull('RealTicketMode', instance.realTicketMode);
  writeNotNull('VipCustomer', instance.vipCustomer);
  writeNotNull('SiteId', instance.siteId);
  writeNotNull('StartTime', instance.startTime);
  writeNotNull('LastPlayedTime', instance.lastPlayedTime);
  writeNotNull('TechnicianCard', instance.technicianCard);
  writeNotNull('TechGames', instance.techGames);
  writeNotNull('TimerResetCard', instance.timerResetCard);
  writeNotNull('LoyaltyPoints', instance.loyaltyPoints);
  writeNotNull('LastUpdatedBy', instance.lastUpdatedBy);
  writeNotNull('CardTypeId', instance.cardTypeId);
  writeNotNull('Guid', instance.guid);
  writeNotNull('UploadSiteId', instance.uploadSiteId);
  writeNotNull('UploadTime', instance.uploadTime);
  writeNotNull('SynchStatus', instance.synchStatus);
  writeNotNull('ExpiryDate', instance.expiryDate);
  writeNotNull('DownloadBatchId', instance.downloadBatchId);
  writeNotNull('RefreshFromHqTime', instance.refreshFromHqTime);
  writeNotNull('MasterEntityId', instance.masterEntityId);
  writeNotNull('AccountIdentifier', instance.accountIdentifier);
  writeNotNull('PrimaryCard', instance.primaryCard);
  writeNotNull('CreatedBy', instance.createdBy);
  writeNotNull('CreationDate', instance.creationDate);
  writeNotNull('BalanceTime', instance.balanceTime);
  writeNotNull('CreditPlusCardBalance', instance.creditPlusCardBalance);
  writeNotNull('CreditPlusCredits', instance.creditPlusCredits);
  writeNotNull('CreditPlusItemPurchase', instance.creditPlusItemPurchase);
  writeNotNull('CreditPlusBonus', instance.creditPlusBonus);
  writeNotNull('CreditPlusTime', instance.creditPlusTime);
  writeNotNull('CreditPlusTickets', instance.creditPlusTickets);
  writeNotNull('CreditPlusLoyaltyPoints', instance.creditPlusLoyaltyPoints);
  writeNotNull(
      'CreditPlusRefundableBalance', instance.creditPlusRefundableBalance);
  writeNotNull('RedeemableCreditPlusCreditsLoyaltyPoints',
      instance.redeemableCreditPlusCreditsLoyaltyPoints);
  writeNotNull('CreditPlusVirtualPoints', instance.creditPlusVirtualPoints);
  writeNotNull('MembershipId', instance.membershipId);
  writeNotNull('MembershipName', instance.membershipName);
  writeNotNull('CustomerName', instance.customerName);
  writeNotNull('GamesBalance', instance.gamesBalance);
  writeNotNull('TotalCreditsBalance', instance.totalCreditsBalance);
  writeNotNull('TotalBonusBalance', instance.totalBonusBalance);
  writeNotNull('TotalTimeBalance', instance.totalTimeBalance);
  writeNotNull('TotalCourtesyBalance', instance.totalCourtesyBalance);
  writeNotNull('TotalLoyaltyBalance', instance.totalLoyaltyBalance);
  writeNotNull('TotalTicketsBalance', instance.totalTicketsBalance);
  writeNotNull('TotalGamesBalance', instance.totalGamesBalance);
  writeNotNull(
      'TotalGamePlayCreditsBalance', instance.totalGamePlayCreditsBalance);
  writeNotNull('AccountCreditPlusDTOList', instance.accountCreditPlusDTOList);
  writeNotNull('AccountGameDTOList', instance.accountGameDTOList);
  return val;
}
