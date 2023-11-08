import 'package:get/instance_manager.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/repositories/select_location_repository_impl.dart';
import 'package:semnox/core/domain/repositories/select_location_repository.dart';
import 'package:semnox/core/domain/use_cases/select_location/get_all_sites_use_case.dart';
import 'package:semnox/core/domain/use_cases/select_location/get_master_site_use_case.dart';

void selectLocationDependecies() {
  //Repository
  Get.lazyPut<SelectLocationRepository>(
    () => SelectLocationRepositoryImpl(
      Get.find<SmartFunApi>(),
    ),
  );

  //Use Cases
  Get.lazyPut<GetAllSitesUseCase>(() => GetAllSitesUseCase(Get.find<SelectLocationRepository>()));
  Get.lazyPut<GetMasterSiteUseCase>(() => GetMasterSiteUseCase(Get.find<SelectLocationRepository>()));
}
