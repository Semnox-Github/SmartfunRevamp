// ignore_for_file: unused_local_variable

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/payment/hosted_payment_gateway.dart';
import 'package:semnox/core/domain/entities/payment/hosted_payment_gateway_request.dart';
import 'package:semnox/core/domain/entities/payment/payment_mode.dart';
import 'package:semnox/core/domain/use_cases/payment/get_hosted_payment_gateways_use_case.dart';
import 'package:semnox/core/domain/use_cases/payment/get_payment_options_use_case.dart';
import 'package:semnox/features/recharge_card/providers/products_price_provider.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

final hostedPaymentGatewayProvider = FutureProvider.autoDispose.family<HostedPaymentGateway, HostedPaymentGatewayRequest>((ref, requestData) async {
  final GetHostedPaymentGatewayUseCase getHostedPaymentGatewayUseCase = Get.find<GetHostedPaymentGatewayUseCase>();
  final response = await getHostedPaymentGatewayUseCase(
    hostedPaymentGateway: requestData.hostedPaymentGateway,
    amount: requestData.amount,
    transactionId: requestData.transactionId,
  );
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});

class PaymentOptionsProvider {
  static final paymentModesProvider = FutureProvider.autoDispose<List<PaymentMode>>((ref) async {
    final response = await SplashScreenNotifier.getHostedPayment();
    return response;
  });
}
