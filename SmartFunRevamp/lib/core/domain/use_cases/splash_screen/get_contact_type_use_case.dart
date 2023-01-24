import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/errors/failures.dart';

class GetContactTypeUseCase {
  final SplashScreenRepository _repository;
  GetContactTypeUseCase(this._repository);
  Future<Either<Failure, dynamic>> call() async {
    return await _repository.getContactType();
  }
}
