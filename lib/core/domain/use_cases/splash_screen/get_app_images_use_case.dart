import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/errors/failures.dart';

class GetAppImagesUseCase {
  final SplashScreenRepository _repository;
  GetAppImagesUseCase(this._repository);
  Future<Either<Failure, dynamic>> call({
    required String imageType,
    required String lastModifiedDate,
  }) async {
    return await _repository.getAppImages(
      imageType: imageType,
      lastModifiedDate: lastModifiedDate,
    );
  }
}
