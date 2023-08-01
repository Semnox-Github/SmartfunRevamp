import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/core/domain/repositories/config_reposity.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class ConfigRepositoryImpl implements ConfigRepository {
  final SmartFunApi _api;

  ConfigRepositoryImpl(this._api);
  @override
  Future<Either<Failure, ParafaitDefaultsResponse>> getParafaitDefaults() async {
    try {
      final systemUser = Get.find<SystemUser>();
      final response = await _api.getParafaitDefaults(
        SplashScreenNotifier.getMasterSite().toString(),
        systemUser.userPKId,
        systemUser.machineId,
      );
      Logger().d(response.data);
      return Right(response.data);
    } on DioException catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }
}
