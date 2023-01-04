import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class SplashScreenRepository {
  Future<Either<Failure, void>> getParafaitDefaults({
    required String siteId,
    required String userPkId,
    required String machineId,
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

  Future<Either<Failure, void>> getHomePageCMS({
    required String moduleName,
    required String isActive,
    required String buildChildRecords,
    required String activeChildRecords,
  });

  Future<Either<Failure, void>> getAllSites();

  Future<Either<Failure, void>> getAppProductsImages({
    required String imageType,
    required String lastModifiedDate,
  });
}
