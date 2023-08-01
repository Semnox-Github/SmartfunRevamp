import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/domain/use_cases/products/get_products_price_use_case.dart';
import 'package:semnox/features/recharge_card/providers/products_price_provider.dart';

part 'buy_card_state.dart';
part 'buy_card_notifier.freezed.dart';

List<CardProduct> _cachedList = [];
// int _lastSite = -1;
final _latSiteProvider = StateProvider.autoDispose<int>((ref) {
  return -1;
});

final buyCardProvider = FutureProvider.autoDispose<List<CardProduct>>((ref) async {
  final siteId = ref.watch(selectedSiteIdProvider);
  final filters = ref.watch(filterProvider);
  final lastSite = ref.watch(_latSiteProvider);
  if (lastSite != siteId) {
    final GetProductsPriceUseCase getProductsPriceUseCase = Get.find<GetProductsPriceUseCase>();
    final response = await getProductsPriceUseCase(siteId);
    ref.read(_latSiteProvider.notifier).update((state) => siteId);
    return response.fold(
      (l) => throw l,
      (r) {
        _cachedList = r;
        if (filters.isEmpty) {
          return r;
        }
        List<int> orderList = [];
        filters.map((e) {
          orderList.addAll(e);
        }).toList();
        orderList.sort();
        final filteredList = r.where((element) => orderList.first <= element.finalPrice && element.finalPrice <= orderList.last).toList();
        return filteredList;
      },
    );
  }

  if (filters.isEmpty) {
    return _cachedList;
  }
  List<int> orderList = [];
  filters.map((e) {
    orderList.addAll(e);
  }).toList();
  orderList.sort();
  final filteredList = _cachedList.where((element) => orderList.first <= element.finalPrice && element.finalPrice <= orderList.last).toList();
  return filteredList;
});

final filterProvider = StateProvider.autoDispose<List<List<int>>>((ref) {
  return [];
});
