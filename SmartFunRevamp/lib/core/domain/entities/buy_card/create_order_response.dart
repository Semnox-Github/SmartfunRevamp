import 'package:json_annotation/json_annotation.dart';
part 'create_order_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CreateOrderResponse {
  int orderId;
  int tableId;
  String orderDate;
  String guestName;
  String guestContactNumber;
  String transactionIdentifier;
  String tentNumber;
  String orderStatus;
  int orderStatusId;
  String orderStatusChangeDate;
  int transactionId;
  String transactionNumber;
  double transactionAmount;
  String transactionStatus;
  int transactionStatusId;
  String paymentStatus;
  int paymentStatusId;
  bool isAccessible;

  CreateOrderResponse(
      this.orderId,
        this.tableId,
        this.orderDate,
        this.guestName,
        this.guestContactNumber,
        this.transactionIdentifier,
        this.tentNumber,
        this.orderStatus,
        this.orderStatusId,
        this.orderStatusChangeDate,
        this.transactionId,
        this.transactionNumber,
        this.transactionAmount,
        this.transactionStatus,
        this.transactionStatusId,
        this.paymentStatus,
        this.paymentStatusId,
        this.isAccessible);

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CreateOrderResponseToJson(this);
}