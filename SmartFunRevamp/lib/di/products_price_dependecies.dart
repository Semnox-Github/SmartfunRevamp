import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/repositories/products_repository_impl.dart';
import 'package:semnox/core/domain/repositories/products_repositories.dart';
import 'package:semnox/core/domain/use_cases/products/create_order_use_case.dart';
import 'package:semnox/core/domain/use_cases/products/estimate_transaction_use_case.dart';
import 'package:semnox/core/domain/use_cases/products/get_products_price_use_case.dart';

import '../core/domain/use_cases/products/add_card_product_use_case.dart';
import '../core/domain/use_cases/products/create_transaction_use_case.dart';
import '../core/domain/use_cases/products/discount_coupon_use_case.dart';
import '../core/domain/use_cases/products/link_to_customer_use_case.dart';
import '../core/domain/use_cases/products/save_transaction_use_case.dart';

void productsPriceDependecies() {
  //Repository
  Get.lazyPut<ProductsRepository>(() => ProductsRepositoryImpl(Get.find()));

  //Use Cases
  Get.lazyPut<GetProductsPriceUseCase>(() => GetProductsPriceUseCase(Get.find()));
  Get.lazyPut<EstimateTransactionUseCase>(() => EstimateTransactionUseCase(Get.find()));
  Get.lazyPut<CreateOrderUseCase>(() => CreateOrderUseCase(Get.find()));
  Get.lazyPut<CreateTransactionUseCase>(() => CreateTransactionUseCase(Get.find()));
  Get.lazyPut<LinkToCustomerUseCase>(() => LinkToCustomerUseCase(Get.find()));
  Get.lazyPut<AddCardProductUseCase>(() => AddCardProductUseCase(Get.find()));
  Get.lazyPut<DiscountCouponUseCase>(() => DiscountCouponUseCase(Get.find()));
  Get.lazyPut<SaveTransactionUseCase>(() => SaveTransactionUseCase(Get.find()));
}
