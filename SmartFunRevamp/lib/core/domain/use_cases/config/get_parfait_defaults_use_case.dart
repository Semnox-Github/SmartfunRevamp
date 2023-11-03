import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/repositories/initial_load_repository.dart';

import 'package:semnox/core/errors/failures.dart';

class GetParafaitDefaultsUseCase {
  final InitialLoadRepository _repository;
  GetParafaitDefaultsUseCase(this._repository);
  Future<Either<Failure, ParafaitDefaultsResponse>> call(int siteId) async {
    return await _repository.getParafaitDefaults(siteId);
  }
}
