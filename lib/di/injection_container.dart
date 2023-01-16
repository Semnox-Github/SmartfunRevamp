import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/parafait_api.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/di/authentication_dependecies.dart';
import 'package:semnox/di/splash_screen_dependencies.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => SmartFunApi());
  sl.registerFactory(() => ParafaitApi());
  authenticaionDependecies(sl);
  splashScreenDependencies(sl);
}

void authenticateApi(SystemUser systemUser) {
  if (sl.isRegistered<SmartFunApi>()) {
    sl.unregister<SmartFunApi>();
    sl.registerFactory(() => SmartFunApi(token: systemUser.webApiToken));
    sl.registerSingleton<SystemUser>(systemUser);
    final executionDTO = ExecutionContextDTO(
      apiUrl: 'https://smartfungigademo.parafait.com',
      authToken: systemUser.webApiToken,
      siteId: systemUser.siteId,
    );
    sl.registerSingleton<ExecutionContextDTO>(executionDTO);
    Logger().d('System User Authenticated');
  }
}

void registerUser(CustomerDTO customerDTO) {
  sl.registerSingleton<CustomerDTO>(customerDTO);
}
