import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class ConfigRepository {
  Future<Either<Failure, ParafaitDefaultsResponse>> getParafaitDefaults();
}
