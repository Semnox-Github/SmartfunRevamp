import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';

class SignUpUserUseCase {
  final AuthenticationRepository _repository;
  SignUpUserUseCase(this._repository);
  Future<Either<Failure, dynamic>> call(Map<String, dynamic> body) async {
    return await _repository.signUpUser(body);
  }
}
