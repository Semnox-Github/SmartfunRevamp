import 'package:json_annotation/json_annotation.dart';
part 'payment_mode.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class PaymentModeContainer{
  final List<PaymentModeDto> PaymentModeContainerDTOList;

  PaymentModeContainer(
      this.PaymentModeContainerDTOList,
      );

  factory PaymentModeContainer.fromJson(Map<String, dynamic> json) => _$PaymentModeContainerFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModeContainerToJson(this);

}

@JsonSerializable(fieldRename: FieldRename.pascal)
class PaymentModeDto {
  final int paymentModeId;
  final String paymentMode;
  final String imageFileName;
  final int Gateway;

  PaymentModeDto(this.paymentModeId, this.paymentMode, this.imageFileName,this.Gateway);
  factory PaymentModeDto.fromJson(Map<String, dynamic> json) => _$PaymentModeDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModeDtoToJson(this);
}

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
