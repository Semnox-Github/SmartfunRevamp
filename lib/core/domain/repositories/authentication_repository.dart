import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/sign_up_entity.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, void>> loginUser(Map<String, dynamic> body);
  Future<Either<Failure, void>> signUpUser(SignUpEntity signUpEntity);
}
