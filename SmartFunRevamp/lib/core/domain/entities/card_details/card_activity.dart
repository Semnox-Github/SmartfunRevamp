import 'package:json_annotation/json_annotation.dart';
part 'card_activity.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CardActivity {
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

  CardActivity(
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
  );
  factory CardActivity.fromJson(Map<String, dynamic> json) => _$CardActivityFromJson(json);
  Map<String, dynamic> toJson() => _$CardActivityToJson(this);
}
