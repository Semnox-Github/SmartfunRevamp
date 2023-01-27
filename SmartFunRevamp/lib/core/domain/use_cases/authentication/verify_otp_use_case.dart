import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';

class VerifyOTPUseCase {
  final AuthenticationRepository _repository;
  VerifyOTPUseCase(this._repository);
  Future<Either<Failure, bool>> call(Map<String, dynamic> body, String otpId) async {
    return await _repository.verifyOTP(body, otpId);
  }
}
