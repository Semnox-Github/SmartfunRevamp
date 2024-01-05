import 'package:dartz/dartz.dart';

import '../../../errors/failures.dart';
import '../../entities/posMachine/posmachine_dto.dart';
import '../../repositories/initial_load_repository.dart';

class GetPosMachineUseCase {
  final InitialLoadRepository _repository;
  GetPosMachineUseCase(this._repository);
  Future<Either<Failure, PosMachineContainer>> call({
    required String siteId,
  }) async {
    return await _repository.getPosMachine(
      siteId: siteId,
    );
  }
}