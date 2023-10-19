import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/entities/data.dart';
import 'package:semnox/core/domain/entities/language/language_container_dto.dart';
import 'package:semnox/core/domain/entities/lookups/lookups_dto.dart';

import 'package:semnox/core/domain/repositories/initial_load_repository.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/utils/extensions.dart';

class InitialLoadRepositoryImpl implements InitialLoadRepository {
  final SmartFunApi _api;
  final LocalDataSource _localDataSource;

  InitialLoadRepositoryImpl(this._api, this._localDataSource);

  @override
  Future<Either<Failure, LanguageContainerDTO>> getParafaitLanguages({required String siteId}) async {
    try {
      final localLanguagesMap = await _localDataSource.retrieveJsonClass(LocalDataSource.kLanguagesContainer);
      if (localLanguagesMap == null) {
        final localJson = await json.decode(await rootBundle.loadString('assets/json/language_container.json'))
            as Map<String, dynamic>;
        final response = Data<LanguageContainerDTO>.fromJson(
            localJson, (json) => LanguageContainerDTO.fromJson(json as Map<String, dynamic>));
        _localDataSource.saveCustomClass(LocalDataSource.kLanguagesContainer, response.data.toJson());
        _updateLocalLanguages(siteId);
        return Right(response.data);
      } else {
        final localLanguages = LanguageContainerDTO.fromJson(localLanguagesMap);
        _updateLocalLanguages(siteId);
        return Right(localLanguages);
      }
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  void _updateLocalLanguages(String siteId) {
    _api.getParafaitLanguages(siteId).then((value) {
      Logger().d("Background Update Success");
      _localDataSource.saveCustomClass(LocalDataSource.kLanguagesContainer, value.data.toJson());
    }).catchError((e) {
      Logger().e("Background Update Failed");
      Logger().e(e);
    });
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getStringsForLocalization(
      {required String siteId, required String languageId, String outputForm = 'JSON'}) async {
    try {
      final response = await _api.getStringsForLocalization(siteId, languageId, outputForm);

      return Right(Map<String, dynamic>.from(response.data));
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, LookupsContainer>> getLookups({required String siteId, bool rebuildCache = true}) async {
    try {
      final response = await _api.getLookups(siteId, rebuildCache);

      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }
}
