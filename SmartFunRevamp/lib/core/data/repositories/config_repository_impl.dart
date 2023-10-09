import 'package:dartz/dartz.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/core/domain/repositories/config_reposity.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/utils/extensions.dart';

class ConfigRepositoryImpl implements ConfigRepository {
  final SmartFunApi _api;

  ConfigRepositoryImpl(this._api);
  @override
  Future<Either<Failure, ParafaitDefaultsResponse>> getParafaitDefaults(int siteId) async {
    try {
      final systemUser = Get.find<SystemUser>();
      final response = await _api.getParafaitDefaults(
        siteId.toString(),
        systemUser.userPKId,
        systemUser.machineId,
      );
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }
}
