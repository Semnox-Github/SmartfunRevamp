// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardProduct _$CardProductFromJson(Map<String, dynamic> json) => CardProduct(
      (json['FinalPrice'] as num).toDouble(),
      json['ProductName'] as String,
      (json['BasePrice'] as num).toDouble(),
      json['ImageFileName'] as String?,
      json['ProductId'] as int?,
      (json['Credits'] as num).toDouble(),
      json['ProductType'] as String,
      json['Description'] as String,
      json['WebDescription'] as String,
      json['QuantityPrompt'] as String,
    );

Map<String, dynamic> _$CardProductToJson(CardProduct instance) {
  final val = <String, dynamic>{
    'ProductName': instance.productName,
    'BasePrice': instance.basePrice,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ImageFileName', instance.imageFileName);
  val['FinalPrice'] = instance.finalPrice;
  writeNotNull('ProductId', instance.productId);
  val['Credits'] = instance.credits;
  val['ProductType'] = instance.productType;
  val['Description'] = instance.description;
  val['WebDescription'] = instance.webDescription;
  val['QuantityPrompt'] = instance.QuantityPrompt;
  return val;
}
