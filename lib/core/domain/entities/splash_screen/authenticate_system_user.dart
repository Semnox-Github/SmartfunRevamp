import 'package:json_annotation/json_annotation.dart';

part 'authenticate_system_user.g.dart';

@JsonSerializable()
class AuthenticateSystemUserResponse {
  final SystemUser data;

  AuthenticateSystemUserResponse(this.data);
  Map<String, dynamic> toJson() => _$AuthenticateSystemUserResponseToJson(this);
  factory AuthenticateSystemUserResponse.fromJson(Map<String, dynamic> json) => _$AuthenticateSystemUserResponseFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class SystemUser {
  final String posMachineGuid;
  final String webApiToken;
  final String? token;
  final int languageId;
  final bool isCorporate;
  final int userPKId;
  final int machineId;
  final int siteId;
  final int sitePKId;
  final String userId;
  final String pOSMachineName;
  final String languageCode;

  SystemUser(
    this.posMachineGuid,
    this.webApiToken,
    this.token,
    this.languageId,
    this.isCorporate,
    this.userPKId,
    this.machineId,
    this.siteId,
    this.sitePKId,
    this.userId,
    this.pOSMachineName,
    this.languageCode,
  );
  factory SystemUser.fromJson(Map<String, dynamic> json) => _$SystemUserFromJson(json);
  Map<String, dynamic> toJson() => _$SystemUserToJson(this);
}
