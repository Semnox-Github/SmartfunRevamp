import 'package:dartz/dartz.dart';

import '../../../errors/failures.dart';
import '../../entities/payment/payment_mode.dart';
import '../../repositories/initial_load_repository.dart';

class GetPaymentModeUseCase {
  final InitialLoadRepository _repository;
  GetPaymentModeUseCase(this._repository);
  Future<Either<Failure, PaymentModeContainer>> call({
    required String siteId,
  }) async {
    return await _repository.getPaymentModesContainer(
      siteId: siteId,
    );
  }
}