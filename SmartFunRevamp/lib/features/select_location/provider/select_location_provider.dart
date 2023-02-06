import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/use_cases/select_location/get_all_sites_use_case.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

final sitesProvider = FutureProvider<List<SiteViewDTO>>((ref) async {
  final GetAllSitesUseCase getAllSitesUseCase = Get.find<GetAllSitesUseCase>();
  final response = await getAllSitesUseCase();
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});
