import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/language/language_container_dto.dart';
import 'package:semnox/core/domain/entities/lookups/lookups_dto.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class InitialLoadRepository {
  Future<Either<Failure, LanguageContainerDTO>> getParafaitLanguages({
    required String siteId,
  });

  Future<Either<Failure, Map<String, dynamic>>> getStringsForLocalization({
    required String siteId,
    required String languageId,
    String outputForm = 'JSON',
  });

  Future<Either<Failure, LookupsContainer>> getLookups({
    required String siteId,
    bool rebuildCache = true,
  });
}
