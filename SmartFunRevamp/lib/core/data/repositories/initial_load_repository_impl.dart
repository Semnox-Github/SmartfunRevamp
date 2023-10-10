import 'package:dartz/dartz.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/language/language_container_dto.dart';
import 'package:semnox/core/domain/entities/lookups/lookups_dto.dart';

import 'package:semnox/core/domain/repositories/initial_load_repository.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/utils/extensions.dart';

class InitialLoadRepositoryImpl implements InitialLoadRepository {
  final SmartFunApi _api;

  InitialLoadRepositoryImpl(this._api);

  @override
  Future<Either<Failure, LanguageContainerDTO>> getParafaitLanguages({required String siteId}) async {
    try {
      final response = await _api.getParafaitLanguages(siteId);
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
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
