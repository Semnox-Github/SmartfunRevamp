import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetConfigExecutionContextUseCase {
  final AuthenticationRepository _repository;
  GetConfigExecutionContextUseCase(this._repository);
  Future<Either<Failure, int>> call() async {
    return await _repository.getConfigExecutionController();
  }
}
