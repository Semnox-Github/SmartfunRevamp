import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/lookups/lookups_dto.dart';
import 'package:semnox/core/domain/repositories/initial_load_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetLookupsUseCase {
  final InitialLoadRepository _repository;
  GetLookupsUseCase(this._repository);
  Future<Either<Failure, LookupsContainer>> call({
    required String siteId,
  }) async {
    return await _repository.getLookups(
      siteId: siteId,
    );
  }
}
