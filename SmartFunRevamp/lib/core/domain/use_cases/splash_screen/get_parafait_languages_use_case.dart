import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/errors/failures.dart';

class GetParafaitLanguagesUseCase {
  final SplashScreenRepository _repository;
  GetParafaitLanguagesUseCase(this._repository);
  Future<Either<Failure, dynamic>> call({required String siteId}) async {
    return await _repository.getParafaitLanguages(siteId: siteId);
  }
}
