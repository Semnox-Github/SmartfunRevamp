import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/parafait_api.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/di/authentication_dependecies.dart';
import 'package:semnox/di/splash_screen_dependencies.dart';

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
    Logger().d('System User Authenticated');
  }
}
 //https://parafaitdevcentral.parafait.com/api/ClientApp/ClientAppVersion?appId=com.semnox.smartfunrevamp&buildNumber=2.130.11&generatedTime=2023-01-05T09%3A08%3A10Z&securityCode=76
