import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/errors/failures.dart';

class GetAllSitesUseCase {
  final SplashScreenRepository _repository;
  GetAllSitesUseCase(this._repository);
  Future<Either<Failure, dynamic>> call() async {
    return await _repository.getAllSites();
  }
}
