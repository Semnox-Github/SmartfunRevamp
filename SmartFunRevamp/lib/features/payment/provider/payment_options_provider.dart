import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/entities/payment/hosted_payment_gateway.dart';
import 'package:semnox/core/domain/entities/payment/payment_mode.dart';
import 'package:semnox/core/domain/use_cases/payment/get_hosted_payment_gateways_use_case.dart';
import 'package:semnox/core/domain/use_cases/payment/get_payment_options_use_case.dart';

class PaymentOptionsProvider {
  static final paymentModesProvider = FutureProvider<List<PaymentMode>>((ref) async {
    
    final GetPaymentOptionsUseCase getPaymentOptionsUseCase = Get.find<GetPaymentOptionsUseCase>();
    
    final response = await getPaymentOptionsUseCase();
    Logger().d(response);
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });

  static final hostedPaymentGatewayProvider = FutureProvider<List<HostedPaymentGateway>>((ref, {hostedPaymentGateway, amount, transactionId }) async {

    final GetHostedPaymentGatewayUseCase getHostedPaymentGatewayUseCase = Get.find<GetHostedPaymentGatewayUseCase>();

    final response = await getHostedPaymentGatewayUseCase(hostedPaymentGateway: hostedPaymentGateway, amount: amount, transactionId: transactionId);
    Logger().d(response);
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });
}