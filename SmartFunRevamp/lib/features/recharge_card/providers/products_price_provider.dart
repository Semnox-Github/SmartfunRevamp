import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/use_cases/products/get_products_price_use_case.dart';

final rechargeProductsProvider = FutureProvider<List<CardProduct>>((ref) async {
  final GetProductsPriceUseCase getProductsPriceUseCase = Get.find<GetProductsPriceUseCase>();

  final response = await getProductsPriceUseCase();

  return response.fold(
    (l) => throw l,
    (r) {
      Logger().d(r.length);
      r.removeWhere((element) => element.productType != 'RECHARGE');
      Logger().d(r.length);
      return r;
    },
  );
});
