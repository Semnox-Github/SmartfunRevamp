import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';

class LoginUserUseCase {
  final AuthenticationRepository _repository;
  LoginUserUseCase(this._repository);
  Future<Either<Failure, dynamic>> call(Map<String, dynamic> body) async {
    return await _repository.loginUser(body);
  }
}
