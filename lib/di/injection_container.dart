import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/di/authentication_dependecies.dart';
import 'package:semnox/di/splash_screen_dependencies.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => SmartFunApi());
  authenticaionDependecies(sl);
  splashScreenDependencies(sl);
}

void authenticateApi(SystemUser systemUser) {
  if (sl.isRegistered<SmartFunApi>()) {
    sl.unregister<SmartFunApi>();
    sl.registerFactory(() => SmartFunApi(systemUser.webApiToken));
    sl.registerSingleton<SystemUser>(systemUser);
    Logger().d('System User Authenticated');
  }
}
