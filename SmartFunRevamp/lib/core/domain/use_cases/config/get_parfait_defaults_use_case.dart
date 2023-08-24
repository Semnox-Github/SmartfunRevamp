import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/repositories/config_reposity.dart';
import 'package:semnox/core/errors/failures.dart';

class GetParafaitDefaultsUseCase {
  final ConfigRepository _repository;
  GetParafaitDefaultsUseCase(this._repository);
  Future<Either<Failure, ParafaitDefaultsResponse>> call(int siteId) async {
    return await _repository.getParafaitDefaults(siteId);
  }
}
