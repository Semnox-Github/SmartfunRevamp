import 'package:json_annotation/json_annotation.dart';
part 'notifications_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class NotificationsResponse {
  final DateTime sendDate;
  final String subject;
  final String body;
  final bool isUnread;

  NotificationsResponse(
    this.sendDate,
    this.subject,
    this.body,
    this.isUnread,
  );
  factory NotificationsResponse.fromJson(Map<String, dynamic> json) => _$NotificationsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}
