import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionServices {
  static Future<bool> getLocationPermision() async {
    var status = await Permission.location.request().isGranted;
    Logger().d(status);
    return status;
  }
}
