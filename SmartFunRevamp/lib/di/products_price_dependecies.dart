import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/repositories/products_repository_impl.dart';
import 'package:semnox/core/domain/repositories/products_repositories.dart';
import 'package:semnox/core/domain/use_cases/products/estimate_transaction_use_case.dart';
import 'package:semnox/core/domain/use_cases/products/get_products_price_use_case.dart';

void productsPriceDependecies() {
  //Repository
  Get.lazyPut<ProductsRepository>(() => ProductsRepositoryImpl(Get.find()));

  //Use Cases
  Get.lazyPut<GetProductsPriceUseCase>(() => GetProductsPriceUseCase(Get.find()));
  Get.lazyPut<EstimateTransactionUseCase>(() => EstimateTransactionUseCase(Get.find()));
}
