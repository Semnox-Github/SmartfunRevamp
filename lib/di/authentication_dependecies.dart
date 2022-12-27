import 'package:get_it/get_it.dart';
import 'package:semnox/features/login/data/repositories/authentication_repository_impl.dart';
import 'package:semnox/features/login/domain/repositories/authentication_repository.dart';
import 'package:semnox/features/login/domain/usecases/login_user_use_case.dart';

void authenticaionDependecies(GetIt sl) {
  //Repository
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(sl()));

  //Use Cases
  sl.registerLazySingleton(() => LoginUserUseCase(sl()));
}
