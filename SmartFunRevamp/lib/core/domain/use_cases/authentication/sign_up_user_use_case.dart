import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class SignUpUserUseCase {
  final AuthenticationRepository _repository;
  SignUpUserUseCase(this._repository);
  Future<Either<Failure, CustomerDTO>> call(Map<String, dynamic> body) async {

    return await _repository.signUpUser(body);
  }
}
