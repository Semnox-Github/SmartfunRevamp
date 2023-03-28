import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, CustomerDTO>> loginUser(Map<String, dynamic> body);
  Future<Either<Failure, CustomerDTO>> signUpUser(Map<String, dynamic> body);
  Future<Either<Failure, String>> sendOTP(Map<String, dynamic> body);
  Future<Either<Failure, bool>> verifyOTP(Map<String, dynamic> body, String otpId);
  Future<Either<Failure, CustomerDTO>> getUserByPhoneOrEmail(String phoneOrEmail);
  Future<Either<Failure, String>> getExecutionController(int siteId);
  Future<Either<Failure, void>> getUserMetaData();
  Future<Either<Failure, void>> sendResetPasswordLink(String phoneOrEmail);
}
