import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, void>> loginUser(Map<String, dynamic> body);
}
