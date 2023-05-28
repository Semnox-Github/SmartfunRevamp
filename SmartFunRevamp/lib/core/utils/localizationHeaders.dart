// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/services.dart';

Future<String> _loadFromAsset() async {
  return await rootBundle.loadString("assets/localization/strings.json");
}

Future parseJsonHeaders() async {
  String jsonString = await _loadFromAsset();
  final jsonResponse = jsonDecode(jsonString);
  return jsonResponse;
}
