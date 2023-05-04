import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetAppConfigurationUseCase {
  final AuthenticationRepository _repository;
  GetAppConfigurationUseCase(this._repository);
  Future<Either<Failure, void>> call(int siteId) async {
    return await _repository.getAppConfigurations(siteId);
  }
}
