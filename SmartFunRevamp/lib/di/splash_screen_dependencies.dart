import 'package:get/instance_manager.dart';
import 'package:semnox/core/api/parafait_api.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/repositories/initial_load_repository_impl.dart';
import 'package:semnox/core/data/repositories/splash_screen_repository_impl.dart';
import 'package:semnox/core/domain/repositories/initial_load_repository.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/authenticate_base_url_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_base_url_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_parafait_languages_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_string_for_localization_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_lookups_use_case.dart';

void splashScreenDependencies() {
  //Repository
  Get.lazyPut<SplashScreenRepository>(
    () => SplashScreenRepositoryImpl(
      Get.find<SmartFunApi>(),
      Get.find<ParafaitApi>(),
    ),
  );
  Get.lazyPut<InitialLoadRepository>(
    () => InitialLoadRepositoryImpl(
      Get.find<SmartFunApi>()
    ),
  );
  //Use Cases
  Get.lazyPut<GetBaseURLUseCase>(() => GetBaseURLUseCase(Get.find()));
  Get.lazyPut<AuthenticateBaseURLUseCase>(() => AuthenticateBaseURLUseCase(Get.find()));
  Get.lazyPut<GetParafaitLanguagesUseCase>(() => GetParafaitLanguagesUseCase(Get.find()));
  Get.lazyPut<GetStringForLocalizationUseCase>(() => GetStringForLocalizationUseCase(Get.find()));
  Get.lazyPut<GetLookupsUseCase>(() => GetLookupsUseCase(Get.find()));
  
}
