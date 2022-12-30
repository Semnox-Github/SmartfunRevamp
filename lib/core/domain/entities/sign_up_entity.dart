import 'package:json_annotation/json_annotation.dart';
part 'sign_up_entity.g.dart';

@JsonSerializable()
class SignUpEntity {
  String? username;
  String? email;
  String? phoneNumber;
  String? dateOfBirth;
  String? password;

  SignUpEntity({
    this.username,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.password,
  });

  Map<String, dynamic> toJson() => _$SignUpEntityToJson(this);
  factory SignUpEntity.fromJson(Map<String, dynamic> json) => _$SignUpEntityFromJson(json);
}
