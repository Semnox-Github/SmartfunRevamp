import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:logger/logger.dart';

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
