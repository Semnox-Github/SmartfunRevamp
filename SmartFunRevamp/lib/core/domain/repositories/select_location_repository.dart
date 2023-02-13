import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

abstract class SelectLocationRepository {
  Future<Either<Failure, List<SiteViewDTO>>> getAllSites();
}
