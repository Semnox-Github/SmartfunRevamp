import 'package:get_it/get_it.dart';
import 'package:semnox/core/data/repositories/splash_screen_repositories_impl.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/authenticate_base_url_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_base_url_use_case.dart';

void splashScreenDependencies(GetIt sl) {
  //Repository
  sl.registerLazySingleton<SplashScreenRepository>(() => SplashScreenRepositoryImpl(sl()));

  //Use Cases
  sl.registerLazySingleton(() => GetBaseURLUseCase(sl()));
  sl.registerLazySingleton(() => AuthenticateBaseURLUseCase(sl()));
}
