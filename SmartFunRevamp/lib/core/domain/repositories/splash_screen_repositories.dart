import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/core/domain/entities/splash_screen/get_base_url_response.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class SplashScreenRepository {
  Future<Either<Failure, GetBaseUrlResponse>> getBaseURLFromCentral({
    required String appId,
    required String buildNumber,
    required String generatedTime,
    required String securityCode,
  });

  Future<Either<Failure, SystemUser>> authenticateBaseURL();

  Future<Either<Failure, void>> getParafaitDefaults({
    required String siteId,
    required String userPkId,
    required String machineId,
    required String token,
  });

  Future<Either<Failure, void>> getParafaitLanguages({
    required String siteId,
  });

  Future<Either<Failure, void>> getStringsForLocalization({
    required String siteId,
    required String languageId,
    String outputForm = 'JSON',
  });

  Future<Either<Failure, void>> getAppImages({
    required String imageType,
    required String lastModifiedDate,
  });

  Future<Either<Failure, void>> getContactType();

  Future<Either<Failure, void>> getHomePageCMS(String moduleName, String token);

  Future<Either<Failure, void>> getAppProductsImages({
    required String imageType,
    required String lastModifiedDate,
  });
}
