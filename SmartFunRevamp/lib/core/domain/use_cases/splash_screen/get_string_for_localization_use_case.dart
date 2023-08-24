import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/initial_load_repository.dart';

import 'package:semnox/core/errors/failures.dart';

class GetStringForLocalizationUseCase {
  final InitialLoadRepository _repository;
  GetStringForLocalizationUseCase(this._repository);
  Future<Either<Failure, Map<String, dynamic>>> call({
    required String siteId,
    required String languageId,
  }) async {
    return await _repository.getStringsForLocalization(
      siteId: siteId,
      languageId: languageId,
    );
  }
}
