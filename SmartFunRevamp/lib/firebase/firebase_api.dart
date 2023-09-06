import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

Future<void> handleNotification(RemoteMessage message) async {
  Logger().d('${message.notification?.title}');
  Logger().d('${message.notification?.body}');
  Logger().d('${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    Logger().d('TOKEN->$fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleNotification);
  }
}
