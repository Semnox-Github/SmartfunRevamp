import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';

class SendLinkResetPasswordUseCase {
  final AuthenticationRepository _repository;
  SendLinkResetPasswordUseCase(this._repository);
  Future<Either<Failure, void>> call(String phoneOrEmail) async {
    return await _repository.sendResetPasswordLink(phoneOrEmail);
  }
}
