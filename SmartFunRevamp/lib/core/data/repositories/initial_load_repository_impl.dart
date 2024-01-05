import 'package:dartz/dartz.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/datasources/initial/initial_local_data_source.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/entities/language/language_container_dto.dart';
import 'package:semnox/core/domain/entities/lookups/lookups_dto.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';

import 'package:semnox/core/domain/repositories/initial_load_repository.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/utils/extensions.dart';

import '../../domain/entities/payment/payment_mode.dart';
import '../../domain/entities/posMachine/posmachine_dto.dart';

class InitialLoadRepositoryImpl implements InitialLoadRepository {
  final SmartFunApi _api;
  final InitialLocalDatasource _localDataSource;

  InitialLoadRepositoryImpl(this._api, this._localDataSource);

  @override
  Future<Either<Failure, LanguageContainerDTO>> getParafaitLanguages({required String siteId}) async {
    try {
      final localLanguages = await _localDataSource.getSavedJson<LanguageContainerDTO>(
        kSavedLanguagesKey,
        (json) {
          return LanguageContainerDTO(
              (json['LanguageContainerDTOList'] as List<dynamic>)
                  .map((e) => LanguageContainerDTOList.fromJson(Map<String, dynamic>.from(e)))
                  .toList(),
              '');
        },
        'assets/json/language_container.json',
      );
      _api.getParafaitLanguages(siteId).then((value) {
        _localDataSource.updateLocalJson(value.data.toJson(), kSavedLanguagesKey);
        Logger().d('Language Container DTO Updated');
      }).catchError((e) {
        Logger().e('Unable to update Local Languages', e);
      });
      return Right(localLanguages);
    } on Exception catch (e, s) {
      Logger().e('Exception ', e, s);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, ParafaitDefaultsResponse>> getParafaitDefaults(int siteId) async {
    try {
      final systemUser = Get.find<SystemUser>();
      final defaults = await _localDataSource.getSavedJson<ParafaitDefaultsResponse>(
        kParafaitDefaultsKey,
        (json) {
          return ParafaitDefaultsResponse(
            (json['ParafaitDefaultContainerDTOList'] as List<dynamic>)
                .map((e) => ParafaitDefault.fromJson(Map<String, dynamic>.from(e)))
                .toList(),
          );
        },
        'assets/json/parafait_defaults_local.json',
      );
      _api.getParafaitDefaults(siteId.toString(), systemUser.userPKId, systemUser.machineId).then((value) {
        _localDataSource.updateLocalJson(value.data.toJson(), kParafaitDefaultsKey);
        Logger().d('Parafait Defaults Updated');
      }).catchError((e) {
        Logger().e('Unable to update Parafait Defaults', e);
      });
      return Right(defaults);
    } on Exception catch (e, s) {
      Logger().e('Exception ', e, s);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getStringsForLocalization({
    required String siteId,
    required String languageId,
    String outputForm = 'JSON',
  }) async {
    try {
      final response = await _api.getStringsForLocalization(siteId, languageId, outputForm);
      await _localDataSource.updateLocalJson(Map<String, dynamic>.from(response.data), kStringForLocalizationKey);
      Logger().d('Local Language Updated');
      return Right(Map<String, dynamic>.from(response.data));
    } on Exception catch (e) {
      Logger().e(e);
      final localStringsForLocalization = await _localDataSource.getSavedJson<Map<String, dynamic>>(
        kStringForLocalizationKey,
        (json) => json,
        'assets/json/strings_for_localization.json',
      );
      return Right(localStringsForLocalization);
    }
  }

  @override
  Future<Either<Failure, LookupsContainer>> getLookups({required String siteId, bool rebuildCache = true}) async {
    try {
      final response = await _api.getLookups(siteId, rebuildCache);
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, PaymentModeContainer>> getPaymentModesContainer({
   required String siteId,
  }) async {
    try {
      final response = await _api.getPaymentModeContainer(siteId);
      //final paymentModes = response.data.PaymentModeContainerDTOList..removeWhere((element) => element.Gateway == -1);
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }


  @override
  Future<Either<Failure, PosMachineContainer>> getPosMachine({required String siteId, bool rebuildCache = true}) async {
    try {
      final response = await _api.getPosMachine(siteId);
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

}
