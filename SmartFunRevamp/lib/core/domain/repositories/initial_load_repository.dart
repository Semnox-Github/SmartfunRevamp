import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/language/language_container_dto.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class InitialLoadRepository {
  Future<Either<Failure, LanguageContainerDTO>> getParafaitLanguages({
    required String siteId,
  });
}


