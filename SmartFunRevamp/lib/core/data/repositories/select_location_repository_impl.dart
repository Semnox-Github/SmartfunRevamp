import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/datasources/initial/initial_local_data_source.dart';
import 'package:semnox/core/domain/repositories/select_location_repository.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

class SelectLocationRepositoryImpl implements SelectLocationRepository {
  final SmartFunApi _api;
  final InitialLocalDatasource _localDataSource;
  SelectLocationRepositoryImpl(this._api, this._localDataSource);

  @override
  Future<Either<Failure, List<SiteViewDTO>>> getAllSites() async {
    try {
      final sites = await _localDataSource.getSavedJson<List<SiteViewDTO>>(
        kAllSitesKey,
        (json) {
          return (json['SiteContainerDTOList'] as List<dynamic>)
              .map((e) => SiteViewDTO.fromJson(Map<String, dynamic>.from(e)))
              .toList();
        },
        'assets/json/all_sites_local.json',
      );
      sites.removeWhere((element) => !element.onlineEnabled!);
      _api.getAllSites().then((value) {
        _localDataSource.updateLocalJson(value.data.toJson(), kAllSitesKey);
        Logger().d('Sites Updated');
      }).catchError((e) {
        Logger().e('Unable to update Sites', e);
      });
      return Right(sites);
    } on Exception catch (e) {
      Logger().e('Exception ', e);
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, List<SiteViewDTO>>> getMasterSite() async {
    try {
      final sites = await _localDataSource.getSavedJson<List<SiteViewDTO>>(
        kAllSitesKey,
        (json) {
          return (json['SiteContainerDTOList'] as List<dynamic>)
              .map((e) => SiteViewDTO.fromJson(Map<String, dynamic>.from(e)))
              .toList();
        },
        'assets/json/all_sites_local.json',
      );
      sites.removeWhere((site) => !site.isMasterSite!);
      return Right(sites);
    } on Exception catch (e) {
      Logger().e('Exception ', e);
      return Left(e.handleException());
    }
  }
}
