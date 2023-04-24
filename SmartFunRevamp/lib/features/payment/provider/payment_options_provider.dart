// ignore_for_file: unused_local_variable

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/entities/payment/hosted_payment_gateway.dart';
import 'package:semnox/core/domain/entities/payment/hosted_payment_gateway_request.dart';
import 'package:semnox/core/domain/entities/payment/payment_mode.dart';
import 'package:semnox/core/domain/use_cases/payment/get_hosted_payment_gateways_use_case.dart';
import 'package:semnox/core/domain/use_cases/payment/get_payment_options_use_case.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class PaymentOptionsProvider {
  static final paymentModesProvider = FutureProvider.autoDispose<List<PaymentMode>>((ref) async {
    final GetPaymentOptionsUseCase getPaymentOptionsUseCase = Get.find<GetPaymentOptionsUseCase>();
    final siteId = Get.find<CustomerDTO>().siteId;
    final response = await getPaymentOptionsUseCase(1040);
    Logger().d(response);
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });

  static final hostedPaymentGatewayProvider = FutureProvider.autoDispose.family<HostedPaymentGateway, HostedPaymentGatewayRequest>((ref, requestData) async {
    final GetHostedPaymentGatewayUseCase getHostedPaymentGatewayUseCase = Get.find<GetHostedPaymentGatewayUseCase>();

    final response = await getHostedPaymentGatewayUseCase(hostedPaymentGateway: requestData.hostedPaymentGateway, amount: requestData.amount, transactionId: requestData.transactionId);
    Logger().d(response);
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });
}
