import 'package:get/instance_manager.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/repositories/config_repository_impl.dart';
import 'package:semnox/core/domain/repositories/config_reposity.dart';
import 'package:semnox/core/domain/use_cases/config/get_parfait_defaults_use_case.dart';

void configDependecies() {
  //Repository
  Get.lazyPut<ConfigRepository>(
    () => ConfigRepositoryImpl(Get.find<SmartFunApi>()),
  );

  //Use Cases
  Get.lazyPut<GetParafaitDefaultsUseCase>(() => GetParafaitDefaultsUseCase(Get.find()));
}
