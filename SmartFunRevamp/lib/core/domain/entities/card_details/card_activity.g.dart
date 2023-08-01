// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardActivity _$CardActivityFromJson(Map<String, dynamic> json) => CardActivity(
      json['AccountId'] as num?,
      json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
      json['Product'] as String?,
      json['Amount'] as num?,
      json['Credits'] as num?,
      json['Courtesy'] as num?,
      json['Bonus'] as num?,
      json['Time'] as num?,
      json['Tokens'],
      json['Tickets'] as num?,
      json['LoyaltyPoints'] as num?,
      json['VirtualPoints'] as num?,
      json['Site'] as String?,
      json['Pos'] as String?,
      json['UserName'] as String?,
      json['Quantity'] as num?,
      json['Price'] as num?,
      json['RefId'] as num?,
      json['RowNumber'] as num?,
      json['ActivityType'] as String?,
      json['Status'] as String?,
      json['PlayCredits'],
      json['CounterItems'],
    );

Map<String, dynamic> _$CardActivityToJson(CardActivity instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AccountId', instance.accountId);
  writeNotNull('Date', instance.date?.toIso8601String());
  writeNotNull('Product', instance.product);
  writeNotNull('Amount', instance.amount);
  writeNotNull('Credits', instance.credits);
  writeNotNull('Courtesy', instance.courtesy);
  writeNotNull('Bonus', instance.bonus);
  writeNotNull('Time', instance.time);
  writeNotNull('Tokens', instance.tokens);
  writeNotNull('Tickets', instance.tickets);
  writeNotNull('LoyaltyPoints', instance.loyaltyPoints);
  writeNotNull('VirtualPoints', instance.virtualPoints);
  writeNotNull('Site', instance.site);
  writeNotNull('Pos', instance.pos);
  writeNotNull('UserName', instance.userName);
  writeNotNull('Quantity', instance.quantity);
  writeNotNull('Price', instance.price);
  writeNotNull('RefId', instance.refId);
  writeNotNull('RowNumber', instance.rowNumber);
  writeNotNull('ActivityType', instance.activityType);
  writeNotNull('Status', instance.status);
  writeNotNull('PlayCredits', instance.playCredits);
  writeNotNull('CounterItems', instance.counterItems);
  return val;
}
