import 'package:json_annotation/json_annotation.dart';
part 'order_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class OrderDetails {
  final int transactionId;
  final num transactionAmount;
  final num transactionDiscountAmount;
  final num taxAmount;
  final num transactionNetAmount;
  final String transactionOTP;
  final String? receiptHTML;
  final String? receipt;
  final String? status;
  final DateTime? transactionDate;
  final List<TransactionLinesDTOList>? transactionLinesDTOList;

  OrderDetails(
    this.transactionId,
    this.transactionAmount,
    this.transactionDiscountAmount,
    this.taxAmount,
    this.transactionNetAmount,
    this.transactionOTP,
    this.transactionDate,
    this.receiptHTML,
    this.receipt,
    this.status,
    this.transactionLinesDTOList,
  );
  factory OrderDetails.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionLinesDTOList {
  final int transactionId;
  final String? cardNumber;
  final String? productName;

  TransactionLinesDTOList(
      this.transactionId, this.cardNumber, this.productName);
  factory TransactionLinesDTOList.fromJson(Map<String, dynamic> json) =>
      _$TransactionLinesDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionLinesDTOListToJson(this);
}
