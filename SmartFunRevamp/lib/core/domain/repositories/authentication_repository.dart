import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/sign_up/user_metadata.dart';
import 'package:semnox/core/domain/entities/splash_screen/app_config_response.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, CustomerDTO>> loginUser(Map<String, dynamic> body);
  Future<Either<Failure, CustomerDTO>> signUpUser(Map<String, dynamic> body);
  Future<Either<Failure, String>> sendOTP(Map<String, dynamic> body);
  Future<Either<Failure, bool>> verifyOTP(
      Map<String, dynamic> body, String otpId);
  Future<Either<Failure, CustomerDTO>> getUserByPhoneOrEmail(
      String phoneOrEmail);
  Future<Either<Failure, String>> getUserExecutionController(int siteId);
  Future<Either<Failure, int>> getConfigExecutionController();
  Future<Either<Failure, List<CustomerUIMetaData>>> getUserMetaData(int siteId);
  Future<Either<Failure, void>> sendResetPasswordLink(String phoneOrEmail);
  Future<Either<Failure, void>> deleteProfile();
  Future<Either<Failure, AppConfigResponse>> getAppConfig(int siteId);
  Future<Either<Failure, HomePageCMSResponse>> getHomePageCMS(String fileName);
  Future<Either<Failure, bool>> validateEmail(String email);
  Future<Either<Failure, void>> registerNotificationToken(int userId);
}
