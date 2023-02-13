import 'package:json_annotation/json_annotation.dart';
part 'discount_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class DiscountApplicationHistoryDTOList {
  final int discountId;
  final String couponNumber;
  final int approvedBy;

  DiscountApplicationHistoryDTOList(this.discountId, this.couponNumber, this.approvedBy);
  factory DiscountApplicationHistoryDTOList.fromJson(Map<String, dynamic> json) => _$DiscountApplicationHistoryDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountApplicationHistoryDTOListToJson(this);
}
