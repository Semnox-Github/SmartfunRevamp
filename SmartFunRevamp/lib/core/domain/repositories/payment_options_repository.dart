import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/payment/payment_mode.dart';
import 'package:semnox/core/domain/entities/payment/hosted_payment_gateway.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class PaymentOptionsRepository {
  Future<Either<Failure, List<PaymentMode>>> getPaymentModes();
  Future<Either<Failure, List<HostedPaymentGateway>>> getHostedPaymentGateways({
    required String hostedPaymentGateway, 
    required int amount, 
    required int transactionId
  });
}