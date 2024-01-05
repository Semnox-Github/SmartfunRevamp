import 'package:json_annotation/json_annotation.dart';
part 'discount_coupon.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class DiscountCountResponse {
    int transactionId;
    int approvedBy;
    double transactionAmount;
    double transactionNetAmount;
    int primaryCardId;
    double transactionDiscountTotal;
    List<TransactionDiscountDTOList> transactionDiscountDTOList;

    DiscountCountResponse(
        this.transactionId,
          this.approvedBy,
          this.transactionAmount,
          this.transactionNetAmount,
          this.primaryCardId,
          this.transactionDiscountTotal,
          this.transactionDiscountDTOList);

    factory DiscountCountResponse.fromJson(Map<String, dynamic> json) => _$DiscountCountResponseFromJson(json);
    Map<String, dynamic> toJson() => _$DiscountCountResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionDiscountDTOList {
  double taxAmount;
  int discountAmount;
  String couponNumber;

  TransactionDiscountDTOList(
      this.taxAmount, this.discountAmount, this.couponNumber);

  factory TransactionDiscountDTOList.fromJson(Map<String, dynamic> json) => _$TransactionDiscountDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionDiscountDTOListToJson(this);
}