import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

const kSavedLanguagesKey = 'local_languages_json';
const kStringForLocalizationKey = 'string_localization';
const kParafaitDefaultsKey = 'parafait_defaults';
const kAllSitesKey = 'all_sites';
const kLocalBox = 'local_json';

abstract class InitialLocalDatasource {
  Future<void> updateLocalJson(Map<String, dynamic> json, String key);
  Future<T> getSavedJson<T>(String key, T Function(Map<String, dynamic> json) fromJsonT, String localJsonPath);
}

class InitiaLocalDataSourceImpl implements InitialLocalDatasource {
  @override
  Future<void> updateLocalJson(Map<String, dynamic> json, String key) async {
    final box = await Hive.openBox<Map>(kLocalBox);
    try {
      await box.put(key, json);
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  Future<T> getSavedJson<T>(String key, T Function(Map<String, dynamic> json) parser, String localJsonPath) async {
    final box = await Hive.openBox<Map>(kLocalBox);
    final localJson = Map<String, dynamic>.from(
        box.get(key, defaultValue: null) ?? await json.decode(await rootBundle.loadString(localJsonPath)));

    final response = parser(localJson);
    return response;
  }
}
