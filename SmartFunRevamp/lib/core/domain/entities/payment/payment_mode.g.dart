// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_mode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMode _$PaymentModeFromJson(Map<String, dynamic> json) => PaymentMode(
      json['PaymentModeId'] as int,
      json['PaymentMode'] as String,
      json['ImageFileName'] as String,
      json['PaymentGateway'] == null
          ? null
          : PaymentGateway.fromJson(
              json['PaymentGateway'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentModeToJson(PaymentMode instance) {
  final val = <String, dynamic>{
    'PaymentModeId': instance.paymentModeId,
    'PaymentMode': instance.paymentMode,
    'ImageFileName': instance.imageFileName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PaymentGateway', instance.paymentGateway?.toJson());
  return val;
}

PaymentGateway _$PaymentGatewayFromJson(Map<String, dynamic> json) =>
    PaymentGateway(
      json['LookupValueId'] as int?,
      json['LookupId'] as int?,
      json['LookupName'] as String?,
      json['LookupValue'] as String?,
    );

Map<String, dynamic> _$PaymentGatewayToJson(PaymentGateway instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('LookupValueId', instance.lookupValueId);
  writeNotNull('LookupId', instance.lookupId);
  writeNotNull('LookupName', instance.lookupName);
  writeNotNull('LookupValue', instance.lookupValue);
  return val;
}
