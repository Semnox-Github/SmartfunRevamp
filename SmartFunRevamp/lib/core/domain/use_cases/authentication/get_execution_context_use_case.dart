import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';

class GetExecutionContextUseCase {
  final AuthenticationRepository _repository;
  GetExecutionContextUseCase(this._repository);
  Future<Either<Failure, String>> call(int siteId) async {
    return await _repository.getUserExecutionController(siteId);
  }
}
