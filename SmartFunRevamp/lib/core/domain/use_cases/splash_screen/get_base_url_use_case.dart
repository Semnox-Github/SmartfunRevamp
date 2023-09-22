import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:semnox/core/domain/entities/splash_screen/get_base_url_response.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/errors/failures.dart';

class GetBaseURLUseCase {
  final SplashScreenRepository _repository;
  GetBaseURLUseCase(this._repository);
  Future<Either<Failure, GetBaseUrlResponse>> call() async {
    return await _repository.getBaseURLFromCentral(
      appId: 'com.semnox.smartfunrevamp',
      buildNumber: dotenv.env['BUILD_NUMBER']!,
      generatedTime: "${DateTime.now().toUtc().toIso8601String().split('.')[0]}Z",
      securityCode: dotenv.env['BUILD_SECURITY_CODE']!,
    );
  }
}
