import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/errors/failures.dart';

class GetStringForLocalizationUseCase {
  final SplashScreenRepository _repository;
  GetStringForLocalizationUseCase(this._repository);
  Future<Either<Failure, dynamic>> call({
    required String siteId,
    required String languageId,
  }) async {
    return await _repository.getStringsForLocalization(
      siteId: siteId,
      languageId: languageId,
    );
  }
}
