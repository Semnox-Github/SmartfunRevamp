import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';

class GetUserMetaDataUseCase {
  final AuthenticationRepository _repository;
  GetUserMetaDataUseCase(this._repository);
  Future<Either<Failure, dynamic>> call() async {
    return await _repository.getUserMetaData();
  }
}
