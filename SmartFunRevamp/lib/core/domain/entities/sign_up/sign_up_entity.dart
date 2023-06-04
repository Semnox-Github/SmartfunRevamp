import 'package:json_annotation/json_annotation.dart';
part 'sign_up_entity.g.dart';

enum MetaDataKeys {
  title('TITLE'),
  firstName('CUSTOMER_NAME'),
  lastName('LAST_NAME'),
  contactPhone('CONTACT_PHONE'),
  weChatAccessToken('WECHAT_ACCESS_TOKEN'),
  taxCode('TAXCODE'),
  email('EMAIL'),
  password('PASSWORD'),
  username('USERNAME'),
  dob('DATE_OF_BIRTH');

  const MetaDataKeys(this.key);
  final String key;
}

@JsonSerializable()
class SignUpEntity {
  String? username;
  String? email;
  String? phoneNumber;
  String? dateOfBirth;
  String? password;
  String? firstName;
  String? lastName;
  String? title;

  SignUpEntity({
    this.username,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.password,
    this.firstName,
    this.lastName,
    this.title,
  });

  Map<String, dynamic> toJson() => _$SignUpEntityToJson(this);
  factory SignUpEntity.fromJson(Map<String, dynamic> json) => _$SignUpEntityFromJson(json);
  factory SignUpEntity.fromMetaData(Map<String, dynamic> json) {
    return SignUpEntity(
      email: json[MetaDataKeys.email.key],
      password: json[MetaDataKeys.password.key],
      phoneNumber: json[MetaDataKeys.contactPhone.key],
      username: json[MetaDataKeys.email.key],
      dateOfBirth: json[MetaDataKeys.dob.key],
      firstName: json[MetaDataKeys.firstName.key],
      lastName: json[MetaDataKeys.lastName.key],
      title: json[MetaDataKeys.title.key],
    );
  }
}
