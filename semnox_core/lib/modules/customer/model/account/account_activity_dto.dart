// To parse this JSON data, do
//
//     final accountActivityDto = accountActivityDtoFromMap(jsonString);

import 'dart:convert';

class AccountActivityDto {
  AccountActivityDto({
    this.accountId,
    this.date,
    this.product,
    this.amount,
    this.credits,
    this.courtesy,
    this.bonus,
    this.time,
    this.tokens,
    this.tickets,
    this.loyaltyPoints,
    this.virtualPoints,
    this.site,
    this.pos,
    this.userName,
    this.quantity,
    this.price,
    this.refId,
    this.rowNumber,
    this.activityType,
    this.status,
    this.playCredits,
    this.counterItems,
  });

  final num? accountId;
  final DateTime? date;
  final String? product;
  final num? amount;
  final num? credits;
  final num? courtesy;
  final num? bonus;
  final num? time;
  final dynamic tokens;
  final num? tickets;
  final num? loyaltyPoints;
  final num? virtualPoints;
  final String? site;
  final String? pos;
  final String? userName;
  final num? quantity;
  final num? price;
  final num? refId;
  final num? rowNumber;
  final String? activityType;
  final String? status;
  final dynamic playCredits;
  final dynamic counterItems;

  factory AccountActivityDto.fromJson(String str) => AccountActivityDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountActivityDto.fromMap(Map<String, dynamic> json) => AccountActivityDto(
        accountId: json["AccountId"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        product: json["Product"],
        amount: json["Amount"],
        credits: json["Credits"],
        courtesy: json["Courtesy"],
        bonus: json["Bonus"],
        time: json["Time"],
        tokens: json["Tokens"],
        tickets: json["Tickets"],
        loyaltyPoints: json["LoyaltyPoints"],
        virtualPoints: json["VirtualPoints"],
        site: json["Site"],
        pos: json["POS"],
        userName: json["UserName"],
        quantity: json["Quantity"],
        price: json["Price"],
        refId: json["RefId"],
        rowNumber: json["RowNumber"],
        activityType: json["ActivityType"],
        status: json["Status"],
        playCredits: json["PlayCredits"],
        counterItems: json["CounterItems"],
      );

  Map<String, dynamic> toMap() => {
        "AccountId": accountId,
        "Date": date == null ? null : date!.toIso8601String(),
        "Product": product,
        "Amount": amount,
        "Credits": credits,
        "Courtesy": courtesy,
        "Bonus": bonus,
        "Time": time,
        "Tokens": tokens,
        "Tickets": tickets,
        "LoyaltyPoints": loyaltyPoints,
        "VirtualPoints": virtualPoints,
        "Site": site,
        "POS": pos,
        "UserName": userName,
        "Quantity": quantity,
        "Price": price,
        "RefId": refId,
        "RowNumber": rowNumber,
        "ActivityType": activityType,
        "Status": status,
        "PlayCredits": playCredits,
        "CounterItems": counterItems,
      };
}
