import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class GetUserByPhoneOrEmailUseCase {
  final AuthenticationRepository _repository;
  GetUserByPhoneOrEmailUseCase(this._repository);
  Future<Either<Failure, CustomerDTO>> call(String phoneOrEmail) async {
    return await _repository.getUserByPhoneOrEmail(phoneOrEmail);
  }
}
