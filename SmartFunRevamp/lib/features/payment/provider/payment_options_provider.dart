import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/entities/payment/payment_mode.dart';
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
}