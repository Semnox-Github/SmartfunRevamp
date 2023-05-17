import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';

class DeleteProfileUseCase {
  final AuthenticationRepository _repository;
  DeleteProfileUseCase(this._repository);
  Future<Either<Failure, void>> call() async {
    return await _repository.deleteProfile();
  }
}
