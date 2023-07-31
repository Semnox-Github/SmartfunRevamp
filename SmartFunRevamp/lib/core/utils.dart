import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:uuid/uuid.dart';

Future<String> generateHashCode({
  required String generatedTime,
  String appId = 'com.semnox.smartfunrevamp',
  String securityCode = '704I5M76',
}) async {
  Logger().d(securityCode);
  final mString = '$appId$securityCode$generatedTime';
  final encodedWord = utf8.encode(mString);
  final hashDigest = sha1.convert(encodedWord);
  final hmachDigest = base64.encode(hashDigest.bytes);
  return hmachDigest;
}

Future<String?> _getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    final iosDeviceInfo = await deviceInfo.iosInfo;

    return iosDeviceInfo.identifierForVendor;
  } else if (Platform.isAndroid) {
    var uuid = const Uuid();
    String guid = uuid.v1();

    return guid;
  }
  return null;
}

Future<String> jwtGenerator({String secretKey = "gUkXp2s5u8x/A?D(G+KbPeShVmYq3t6w"}) async {
  // final dateTime = "${DateTime.now().toUtc().formatDate("EEE, dd MMM yyyy hh:mm:ss")} GMT";
  final dateTime = DateTime.now().toUtc().toString();
  final jwt = JWT(
    // Payload
    {
      'Name': 'com.semnox.smartfunrevamp',
      'UserData': await _getId(),
      'IssuedAt': dateTime,
      'ExpiresAt': dateTime,
    },
  );
  final token = jwt.sign(SecretKey(secretKey));
  return token;
}
