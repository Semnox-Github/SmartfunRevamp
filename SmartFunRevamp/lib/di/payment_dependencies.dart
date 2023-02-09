import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/repositories/payment_options_repository_impl.dart';
import 'package:semnox/core/domain/repositories/payment_options_repository.dart';
import 'package:semnox/core/domain/use_cases/payment/get_hosted_payment_gateways_use_case.dart';
import 'package:semnox/core/domain/use_cases/payment/get_payment_options_use_case.dart';

void paymentDependencies() {
  //Repository
  Get.lazyPut<PaymentOptionsRepository>(() => PaymentOptionsRepositoryImpl(Get.find()));

  //Use Cases
  Get.lazyPut<GetPaymentOptionsUseCase>(() => GetPaymentOptionsUseCase(Get.find()));
  Get.lazyPut<GetHostedPaymentGatewayUseCase>(() => GetHostedPaymentGatewayUseCase(Get.find()));
}