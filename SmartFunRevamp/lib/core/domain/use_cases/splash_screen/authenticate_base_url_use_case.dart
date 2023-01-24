import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/errors/failures.dart';

class AuthenticateBaseURLUseCase {
  final SplashScreenRepository _repository;
  AuthenticateBaseURLUseCase(this._repository);
  Future<Either<Failure, SystemUser>> call() async {
    return await _repository.authenticateBaseURL();
  }
}
