import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/repositories/orders_repository_impl.dart';
import 'package:semnox/core/domain/repositories/orders_repository.dart';
import 'package:semnox/core/domain/use_cases/orders/get_customer_transaction_status_use_case.dart';
import 'package:semnox/core/domain/use_cases/orders/get_customer_transactions_use_case.dart';
import 'package:semnox/core/domain/use_cases/orders/get_transaction_detail_use_case.dart';

void ordersDependencies() {
  //Repository
  Get.lazyPut<OrdersRepository>(() => OrdersRepositoryImpl(Get.find()));

  //Use Cases
  Get.lazyPut<GetCustomerTransactionsUseCase>(
      () => GetCustomerTransactionsUseCase(Get.find()));
  Get.lazyPut<GetTransactionDetailUseCase>(
      () => GetTransactionDetailUseCase(Get.find()));
  Get.lazyPut<GetCustomerTransactionStatusUseCase>(
      () => GetCustomerTransactionStatusUseCase(Get.find()));
}
