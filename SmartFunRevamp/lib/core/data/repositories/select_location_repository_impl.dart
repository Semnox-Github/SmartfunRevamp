import 'package:dartz/dartz.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/repositories/select_location_repository.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

class SelectLocationRepositoryImpl implements SelectLocationRepository {
  final SmartFunApi _api;

  SelectLocationRepositoryImpl(this._api);
  @override
  Future<Either<Failure, List<SiteViewDTO>>> getAllSites() async {
    try {
      final response = await _api.getAllSites();
      final list = response.data.siteContainerDTOList;
      list.removeWhere((site) => !site.onlineEnabled!);
      return Right(list);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

  @override
  Future<Either<Failure, List<SiteViewDTO>>> getMasterSite() async {
    try {
      final response = await _api.getAllSites();
      final list = response.data.siteContainerDTOList;
      list.removeWhere((site) => !site.isMasterSite!);
      return Right(list);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }
}
