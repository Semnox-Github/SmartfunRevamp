import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/payment/hosted_payment_gateway.dart';
import 'package:semnox/core/domain/repositories/payment_options_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetHostedPaymentGatewayUseCase {
  final PaymentOptionsRepository _repository;
  GetHostedPaymentGatewayUseCase(this._repository);
  Future<Either<Failure, HostedPaymentGateway>> call({
    required String hostedPaymentGateway,
    required double amount,
    required int transactionId
  }) async {
    return await _repository.getHostedPaymentGateways(
      hostedPaymentGateway: hostedPaymentGateway,
      amount: amount,
      transactionId: transactionId
    );
  }
}
