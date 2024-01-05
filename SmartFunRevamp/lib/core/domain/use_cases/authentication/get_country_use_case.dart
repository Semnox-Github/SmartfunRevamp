import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';

import '../../entities/sign_up/country_data.dart';

class GetCountryUseCase {
  final AuthenticationRepository _repository;
  GetCountryUseCase(this._repository);
  Future<Either<Failure, List<CountryData>>> call(int siteId) async {
    return await _repository.getCountriesContainer(siteId);
  }
}