import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionServices {
  //TODO: Check request permission for Android
  static Future<bool> getLocationPermision() async {
    var status = await Permission.location.request().isGranted;
    Logger().d(status);
    return status;
  }
}
