import 'package:json_annotation/json_annotation.dart';
part 'order_status.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class OrderStatus {
  final int transactionId;
  final String transactionStatus;
  final String? paymentStatus;
  final String? message;

  OrderStatus(this.transactionId, this.transactionStatus, this.paymentStatus, this.message);
  factory OrderStatus.fromJson(Map<String, dynamic> json) => _$OrderStatusFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStatusToJson(this);
}
