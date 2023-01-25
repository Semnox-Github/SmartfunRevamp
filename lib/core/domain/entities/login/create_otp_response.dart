import 'package:json_annotation/json_annotation.dart';
part 'create_otp_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CreateOtpResponse {
  final int id;
  final String code;
  final String phone;
  final String? countryCode;
  final String? emailId;
  final String source;
  final bool isVerified;
  final int remainingAttempts;
  final DateTime expiryTime;
  final String guid;
  final bool isActive;
  final int siteId;
  final bool synchStatus;
  final int masterEntityId;

  CreateOtpResponse(
    this.id,
    this.code,
    this.phone,
    this.countryCode,
    this.emailId,
    this.source,
    this.isVerified,
    this.remainingAttempts,
    this.expiryTime,
    this.guid,
    this.isActive,
    this.siteId,
    this.synchStatus,
    this.masterEntityId,
  );
  factory CreateOtpResponse.fromJson(Map<String, dynamic> json) => _$CreateOtpResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CreateOtpResponseToJson(this);
}
