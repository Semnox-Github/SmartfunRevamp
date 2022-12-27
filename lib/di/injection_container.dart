import 'package:get_it/get_it.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/di/authentication_dependecies.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => SmartFunApi());
  authenticaionDependecies(sl);
}
