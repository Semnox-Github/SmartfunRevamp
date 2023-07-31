import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';

class VerifyEmailExistsUseCase {
  final AuthenticationRepository _repository;
  VerifyEmailExistsUseCase(this._repository);
  Future<Either<Failure, bool>> call(String phoneOrEmail) async {
    return await _repository.validateEmail(phoneOrEmail);
  }
}
