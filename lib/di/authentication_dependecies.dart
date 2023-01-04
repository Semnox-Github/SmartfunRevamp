import 'package:get_it/get_it.dart';
import 'package:semnox/core/data/repositories/authentication_repository_impl.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';
import 'package:semnox/core/domain/use_cases/authentication/login_user_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/sign_up_use_case.dart';

void authenticaionDependecies(GetIt sl) {
  //Repository
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(sl()));

  //Use Cases
  sl.registerLazySingleton(() => LoginUserUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
}
