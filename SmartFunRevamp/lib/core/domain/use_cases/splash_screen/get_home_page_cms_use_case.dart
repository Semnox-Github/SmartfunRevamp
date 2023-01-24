import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/errors/failures.dart';

class GetHomePageCMSUseCase {
  final SplashScreenRepository _repository;
  GetHomePageCMSUseCase(this._repository);
  Future<Either<Failure, dynamic>> call({
    required String moduleName,
    required String isActive,
    required String buildChildRecords,
    required String activeChildRecords,
  }) async {
    return await _repository.getHomePageCMS(
      activeChildRecords: activeChildRecords,
      buildChildRecords: buildChildRecords,
      isActive: isActive,
      moduleName: moduleName,
    );
  }
}
