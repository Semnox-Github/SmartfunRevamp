import 'package:json_annotation/json_annotation.dart';
part 'payment_mode.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class PaymentMode {
  final int paymentModeId;
  final String paymentMode;
  final String imageFileName;
  final PaymentGateway? paymentGateway;

  PaymentMode(this.paymentModeId, this.paymentMode, this.imageFileName, this.paymentGateway);
  factory PaymentMode.fromJson(Map<String, dynamic> json) => _$PaymentModeFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModeToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class PaymentGateway {
  final int? lookupValueId;
  final int? lookupId;
  final String? lookupName;
  final String? lookupValue;

  PaymentGateway(this.lookupValueId, this.lookupId, this.lookupName, this.lookupValue);
  factory PaymentGateway.fromJson(Map<String, dynamic> json) => _$PaymentGatewayFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentGatewayToJson(this);
}
