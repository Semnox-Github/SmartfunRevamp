import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/payment/payment_mode.dart';
import 'package:semnox/core/domain/repositories/payment_options_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetPaymentOptionsUseCase {
  final PaymentOptionsRepository _repository;
  GetPaymentOptionsUseCase(this._repository);
  Future<Either<Failure, List<PaymentMode>>> call(int siteId) async {
    return await _repository.getPaymentModes(siteId.toString());
  }
}
