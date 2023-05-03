import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/initial_load_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetParafaitLanguagesUseCase {
  final InitialLoadRepository _repository;
  GetParafaitLanguagesUseCase(this._repository);
  Future<Either<Failure, dynamic>> call({required String siteId}) async {
    return await _repository.getParafaitLanguages(siteId: siteId);
  }
}
