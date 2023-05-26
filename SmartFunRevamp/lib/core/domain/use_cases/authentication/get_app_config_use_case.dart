import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/splash_screen/app_config_response.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';

class GetAppConfigUseCase {
  final AuthenticationRepository _repository;
  GetAppConfigUseCase(this._repository);
  Future<Either<Failure, AppConfigResponse>> call(int siteId) async {
    return await _repository.getAppConfig(siteId);
  }
}
