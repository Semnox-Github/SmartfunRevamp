import 'package:json_annotation/json_annotation.dart';
part 'card_product.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class CardProduct {
  final String productName;
  final double basePrice;
  final String imageFileName;
  final double finalPrice;
  final int? productId;
  final double credits;

  CardProduct(this.finalPrice, this.productName, this.basePrice, this.imageFileName, this.productId, this.credits);
  factory CardProduct.fromJson(Map<String, dynamic> json) => _$CardProductFromJson(json);
  Map<String, dynamic> toJson() => _$CardProductToJson(this);
}
