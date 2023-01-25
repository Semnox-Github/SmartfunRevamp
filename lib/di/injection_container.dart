import 'package:semnox/core/api/parafait_api.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/di/authentication_dependecies.dart';
import 'package:semnox/di/splash_screen_dependencies.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:get/get.dart';

Future<void> init() async {
  Get.create(() => SmartFunApi());
  Get.create(() => ParafaitApi());
  splashScreenDependencies();
  authenticaionDependecies();
}

void authenticateApi(SystemUser systemUser, String baseURL) {
  // if (sl.isRegistered<SmartFunApi>()) {
  //   sl.unregister<SmartFunApi>();
  //   sl.registerFactory(() => SmartFunApi(token: systemUser.webApiToken, baseUrl: baseURL));
  //   sl.registerSingleton<SystemUser>(systemUser);
  //   final executionDTO = ExecutionContextDTO(
  //     apiUrl: baseURL,
  //     authToken: systemUser.webApiToken,
  //     siteId: systemUser.siteId,
  //   );
  //   sl.registerSingleton<ExecutionContextDTO>(executionDTO);
  //   Logger().d('System User Authenticated');
  // }
}

void registerUser(CustomerDTO customerDTO) {
  // sl.registerSingleton<CustomerDTO>(customerDTO);
}
