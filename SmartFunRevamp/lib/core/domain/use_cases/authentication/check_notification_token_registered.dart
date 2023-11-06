import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';

class CheckNotificationTokenRegisteredUseCase {
  final AuthenticationRepository _repository;
  CheckNotificationTokenRegisteredUseCase(this._repository);
  Future<Either<Failure, void>> call({required int userId}) async {
    return await _repository.registerNotificationToken(userId);
  }
}
