import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/parafait_api.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/core/domain/entities/splash_screen/get_base_url_response.dart';
import 'package:semnox/core/domain/repositories/splash_screen_repositories.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/utils.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

import '../datasources/local_data_source.dart';

class SplashScreenRepositoryImpl implements SplashScreenRepository {
  final SmartFunApi _api;
  final ParafaitApi _parafaitApi;
  SplashScreenRepositoryImpl(this._api, this._parafaitApi);

  @override
  Future<Either<Failure, GetBaseUrlResponse>> getBaseURLFromCentral(
      {required String appId,
      required String buildNumber,
      required String generatedTime,
      required String securityCode}) async {
    try {
      final response = await _parafaitApi.getBaseURLFromCentral(
        appId,
        buildNumber,
        generatedTime,
        securityCode.substring(securityCode.length - 2),
        {
          "codeHash": await generateHashCode(
            generatedTime: generatedTime,
            securityCode: securityCode,
          ),
        },
      );
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, SystemUser>> authenticateBaseURL() async {
    try {
      final response = await _api.authenticateSystemUser(
          {
            "LoginId": dotenv.env['LOGIN_ID'],
            "Password": dotenv.env['PASSWORD'],
            "MachineName" : dotenv.env['MACHINE_NAME']
          }
      );

      var siteId = "";
      var storedSiteViewDto = await GluttonLocalDataSource().retrieveValue(LocalDataSource.kSelectedSite);
      if(storedSiteViewDto != null){
        final site= SiteViewDTO.fromJson(storedSiteViewDto);
        if(site?.siteId != null){
          siteId = site?.siteId.toString() ?? "";
        }
      }


      final systemUserResponse = await _api.authenticateSystemUserContext(
          {
            "LoginId": dotenv.env['LOGIN_ID'],
            "Password": dotenv.env['PASSWORD'],
            "Siteid": siteId,
            "MachineName" : dotenv.env['MACHINE_NAME']
          }
      );
      final systemUser = SystemUser.fromJson(Map<String, dynamic>.from(systemUserResponse.response.data)['data']);

      if(storedSiteViewDto != null) {
        var Site =
        SiteViewDTO(siteId: systemUserResponse.data['data']['SiteId'],
            openDate: DateTime.now(),
            closureDate: DateTime.now());
        await GluttonLocalDataSource().saveCustomClass(
            LocalDataSource.kSelectedSite, Site.toJson());
      }

      // await GluttonLocalDataSource().saveValue(LocalDataSource.kSelectedSite, systemUserResponse.response.data['data']['SiteId'].toString());
      GluttonLocalDataSource().saveValue(LocalDataSource.POSMachineId,systemUserResponse.response.data['data']['MachineId']);
      systemUser.webApiToken = systemUserResponse.response.data['data']['WebApiToken'];
      return Right(systemUser);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, void>> getAppImages({required String imageType, required String lastModifiedDate}) async {
    try {
      final response = await _api.getAppImages(imageType, lastModifiedDate);
      Logger().d(response);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, void>> getAppProductsImages(
      {required String imageType, required String lastModifiedDate}) async {
    try {
      final response = await _api.getAppProductsImages(lastModifiedDate, imageType);
      Logger().d(response);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, void>> getContactType() async {
    try {
      final response = await _api.getContactType();
      Logger().d(response);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, void>> getParafaitLanguages({required String siteId}) async {
    try {
      final response = await _api.getParafaitLanguages(siteId);
      Logger().d(response);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }
}
