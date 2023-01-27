import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';

class SendOTPUseCase {
  final AuthenticationRepository _repository;
  SendOTPUseCase(this._repository);
  Future<Either<Failure, String>> call(Map<String, dynamic> body) async {
    return await _repository.sendOTP(body);
  }
}
