import 'package:json_annotation/json_annotation.dart';
part 'notification_register_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class NotificationRegisterEntity {
  final int id;
  final int customerId;
  final String pushNotificationToken;
  final String deviceType;
  final bool isActive;
  final bool customerSignedIn;

  NotificationRegisterEntity(
    this.id,
    this.customerId,
    this.pushNotificationToken,
    this.deviceType, {
    this.isActive = true,
    this.customerSignedIn = true,
  });

  factory NotificationRegisterEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationRegisterEntityFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationRegisterEntityToJson(this);

  map(Function(dynamic e) param0) {}

  String toString() {
    return 'NotificationRegisterEntity(id: $id, customerId: $customerId, pushNotificationToken: $pushNotificationToken, deviceType: $deviceType)';
  }
}
