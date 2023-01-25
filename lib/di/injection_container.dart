import 'package:logger/logger.dart';
import 'package:semnox/core/api/parafait_api.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/di/authentication_dependecies.dart';
import 'package:semnox/di/splash_screen_dependencies.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:get/get.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

Future<void> init() async {
  Get.lazyPut(() => ParafaitApi());
  Get.lazyPut(() => SmartFunApi());
  splashScreenDependencies();
  authenticaionDependecies();
}

void authenticateApi(SystemUser systemUser, String baseURL) {
  Get.replace(SmartFunApi(systemUser.webApiToken, baseURL));
  Get.put<SystemUser>(systemUser);
  ExecutionContextDTO executionDTO = ExecutionContextDTO(
    apiUrl: baseURL,
    authToken: systemUser.webApiToken,
    siteId: systemUser.siteId,
  );

  // Get.lazyPut<ExecutionContextDTO?>(() => executionDTO);
  Get.create<ExecutionContextDTO>(() => executionDTO);
  Logger().d('System User Authenticated');
}

void registerUser(CustomerDTO customerDTO) {
  Get.put<CustomerDTO>(customerDTO);
}
