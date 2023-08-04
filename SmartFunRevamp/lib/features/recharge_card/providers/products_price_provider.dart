import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/use_cases/products/get_products_price_use_case.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/select_location/provider/select_location_provider.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

final selectedSiteIdProvider = StateProvider.autoDispose<int>((ref) {
  final sites = List<SiteViewDTO>.from(ref.watch(getAllSitesProvider).value ?? []);
  final userSite = ref.read(loginProvider.notifier).selectedSite?.siteId ?? -1;
  final selectedSite = sites.firstWhere(
    (element) => element.siteId == userSite,
    orElse: () => sites.first,
  );
  return selectedSite.siteId ?? -1;
});
final rechargeProductsProvider = FutureProvider.autoDispose<List<CardProduct>>((ref) async {
  final GetProductsPriceUseCase getProductsPriceUseCase = Get.find<GetProductsPriceUseCase>();
  final siteId = ref.watch(selectedSiteIdProvider);
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
