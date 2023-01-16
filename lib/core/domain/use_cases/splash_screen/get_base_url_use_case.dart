import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/errors/failures.dart';

class GetBaseURLUseCase {
  final SplashScreenRepository _repository;
  GetBaseURLUseCase(this._repository);
  Future<Either<Failure, dynamic>> call() async {
    return await _repository.getBaseURLFromCentral(
      appId: 'com.semnox.smartfunrevamp',
      buildNumber: '2.130.11',
      generatedTime: "${DateTime.now().toUtc().toIso8601String().split('.')[0]}Z",
      securityCode: '76',
    );
  }
}
