import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/errors/failures.dart';

class GetHomePageCMSUseCase {
  final SplashScreenRepository _repository;
  GetHomePageCMSUseCase(this._repository);
  Future<Either<Failure, List<CMSContent>>> call({String moduleName = 'SMARTFUN_HOMEPAGE', required String token}) async {
    return await _repository.getHomePageCMS(moduleName, token);
  }
}
