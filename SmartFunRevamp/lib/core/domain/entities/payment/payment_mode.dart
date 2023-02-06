import 'package:json_annotation/json_annotation.dart';
part 'payment_mode.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class PaymentMode {
  final int paymentModeId;
  final String paymentMode;
  final String imageFileName;
  final String LookupValue;

  PaymentMode(this.paymentModeId, this.paymentMode, this.imageFileName, this.LookupValue);
  factory PaymentMode.fromJson(Map<String, dynamic> json) => _$PaymentModeFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModeToJson(this);
}
