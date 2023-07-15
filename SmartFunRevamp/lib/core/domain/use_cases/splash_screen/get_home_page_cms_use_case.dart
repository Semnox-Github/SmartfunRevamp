import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetHomePageCMSUseCase {
  final AuthenticationRepository _repository;
  GetHomePageCMSUseCase(this._repository);
  Future<Either<Failure, HomePageCMSResponse>> call() async {
    return await _repository.getHomePageCMS();
  }
}
