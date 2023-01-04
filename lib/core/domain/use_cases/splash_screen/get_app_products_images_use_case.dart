import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/errors/failures.dart';

class GetAppProductImagesUseCase {
  final SplashScreenRepository _repository;
  GetAppProductImagesUseCase(this._repository);
  Future<Either<Failure, dynamic>> call({
    required String imageType,
    required String lastModifiedDate,
  }) async {
    return await _repository.getAppProductsImages(
      imageType: imageType,
      lastModifiedDate: lastModifiedDate,
    );
  }
}
