import 'package:get/instance_manager.dart';
import 'package:semnox/core/api/parafait_api.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/repositories/splash_screen_repositories_impl.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/authenticate_base_url_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_base_url_use_case.dart';

void splashScreenDependencies() {
  //Repository
  Get.lazyPut<SplashScreenRepository>(
    () => SplashScreenRepositoryImpl(
      Get.find<SmartFunApi>(),
      Get.find<ParafaitApi>(),
    ),
  );

  //Use Cases
  Get.lazyPut<GetBaseURLUseCase>(() => GetBaseURLUseCase(Get.find()));
  Get.lazyPut<AuthenticateBaseURLUseCase>(() => AuthenticateBaseURLUseCase(Get.find()));
}
