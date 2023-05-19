import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/use_cases/products/get_products_price_use_case.dart';

final rechargeProductsProvider = FutureProvider.autoDispose.family<List<CardProduct>, int>((ref, siteId) async {
  final GetProductsPriceUseCase getProductsPriceUseCase = Get.find<GetProductsPriceUseCase>();
  final response = await getProductsPriceUseCase(siteId);
  return response.fold(
    (l) => throw l,
    (r) {
      Logger().d(r.length);
      r.removeWhere((element) => element.productType != 'RECHARGE' && element.productType != 'VARIABLECARD');
      Logger().d(r.length);
      return r;
    },
  );
});

final allProductsProvider = FutureProvider.autoDispose.family<List<CardProduct>, int>((ref, siteId) async {
  final GetProductsPriceUseCase getProductsPriceUseCase = Get.find<GetProductsPriceUseCase>();
  final response = await getProductsPriceUseCase(siteId);
  return response.fold(
    (l) => throw l,
    (r) {
      Logger().d(r.length);
      Logger().d(r.length);
      return r;
    },
  );
});
