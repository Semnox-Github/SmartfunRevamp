import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/repositories/select_location_repository.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

class SelectLocationRepositoryImpl implements SelectLocationRepository {
  final SmartFunApi _api;
  final LocalDataSource _localDataSource;

  SelectLocationRepositoryImpl(this._api, this._localDataSource);
  @override
  Future<Either<Failure, List<SiteViewDTO>>> getAllSites() async {
    try {
      if ((await _localDataSource.retrieveSites()).isEmpty) {
        final response = await _api.getAllSites();
        final list = response.data.siteContainerDTOList;
        await _localDataSource.saveSites(list);
        list.removeWhere((site) => !site.onlineEnabled!);
        return Right(list);
      } else {
        final list = await _localDataSource.retrieveSites();
        list.removeWhere((site) => !site.onlineEnabled!);
        for (var element in list) {
          Logger().d(element.siteId);
        }
        return Right(list);
      }
    } on DioError catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    }
  }
}
