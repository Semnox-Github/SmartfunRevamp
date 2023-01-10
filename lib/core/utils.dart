import 'dart:convert';

import 'package:cryptography/cryptography.dart';

Future<String> generateHashCode({
  required String generatedTime,
  String appId = 'com.semnox.smartfunrevamp',
  String securityCode = '76',
}) async {
  final mString = '$appId$securityCode$generatedTime';
  final encodedWord = utf8.encode(mString);
  final hashDigest = await Sha1().hash(encodedWord);
  final hmachDigest = base64.encode(hashDigest.bytes);
  return hmachDigest;
}
