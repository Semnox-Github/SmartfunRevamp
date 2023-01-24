import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/sign_up/sign_up_entity.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';

class SignUpUseCase {
  final AuthenticationRepository _repository;
  SignUpUseCase(this._repository);
  Future<Either<Failure, dynamic>> call(SignUpEntity signUpEntity) async {
    return await _repository.signUpUser(signUpEntity);
  }
}
