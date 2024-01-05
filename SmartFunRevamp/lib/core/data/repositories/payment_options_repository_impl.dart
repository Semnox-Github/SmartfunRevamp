import 'package:dartz/dartz.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/payment/payment_mode.dart';
import 'package:semnox/core/domain/entities/payment/hosted_payment_gateway.dart';
import 'package:semnox/core/domain/repositories/payment_options_repository.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/utils/extensions.dart';

class PaymentOptionsRepositoryImpl implements PaymentOptionsRepository {
  final SmartFunApi _api;

  PaymentOptionsRepositoryImpl(this._api);

  @override
  Future<Either<Failure, List<PaymentMode>>> getPaymentModeContainer(
    String siteId,
  ) async {
    try {
      final response = await _api.getPaymentModes(siteId);
      final paymentModes = response.data..removeWhere((element) => element.paymentGateway == null);
      return Right(paymentModes);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }



  @override
  Future<Either<Failure, HostedPaymentGateway>> getHostedPaymentGateways(
      {required String hostedPaymentGateway, required double amount, required int transactionId}) async {
    try {
      final response = await _api.getHostedPaymentGateways(hostedPaymentGateway, amount, transactionId);
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.handleException());
    }
  }

}
