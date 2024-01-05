import 'package:dartz/dartz.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';

import '../../entities/sign_up/user_metadataui.dart';

class GetUserMetaDataUseCase {
  final AuthenticationRepository _repository;
  GetUserMetaDataUseCase(this._repository);
  Future<Either<Failure, List<CustomerFieldConfiguration>>> call(int siteId) async {
    return await _repository.getUserMetaData(siteId);
  }
}
