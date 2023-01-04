import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/errors/failures.dart';

class GetParafaitDefaultsUseCase {
  final SplashScreenRepository _repository;
  GetParafaitDefaultsUseCase(this._repository);
  Future<Either<Failure, dynamic>> call({
    required String siteId,
    required String userPkId,
    required String machineId,
  }) async {
    return await _repository.getParafaitDefaults(
      siteId: siteId,
      userPkId: userPkId,
      machineId: machineId,
    );
  }
}
