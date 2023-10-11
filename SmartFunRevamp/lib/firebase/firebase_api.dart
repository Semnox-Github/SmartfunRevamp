import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
part 'firebase_api.g.dart';

Future<void> handleNotification(RemoteMessage message) async {
  Logger().d('${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.setAutoInitEnabled(true);
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    Logger().d('TOKEN->$fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleNotification);
  }
}

@JsonSerializable()
class NotificationsData {
  final String path;
  final String id;

  NotificationsData(this.path, this.id);
  factory NotificationsData.fromJson(Map<String, dynamic> json) =>
      _$NotificationsDataFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationsDataToJson(this);
}
