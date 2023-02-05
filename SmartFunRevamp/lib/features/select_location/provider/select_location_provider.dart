import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/use_cases/select_location/get_all_sites_use_case.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';
part 'select_location_state.dart';
part 'select_location_provider.freezed.dart';

final selectLocationStateProvider = StateNotifierProvider<SelectLocationProvider, SelectLocationState>(
  (ref) => SelectLocationProvider(
    Get.find<GetAllSitesUseCase>(),
  ),
);

class SelectLocationProvider extends StateNotifier<SelectLocationState> {
  final GetAllSitesUseCase _getAllSitesUseCase;
  List<SiteViewDTO> _sites = [];
  SelectLocationProvider(this._getAllSitesUseCase) : super(const _Initial()) {
    getSites();
  }

  void getSites() async {
    state = const _InProgress();
    final response = await _getAllSitesUseCase();
    response.fold(
      (l) => state = _Error(l.message),
      (r) {
        state = _Success(r);
        _sites = r;
      },
    );
  }

  void filterSites(String filter) {
    state = const _InProgress();
    if (filter.isEmpty) {
      state = _Success(_sites);
    } else {
      final filtered = _sites.where((element) => element.siteName?.toLowerCase().contains(filter.toLowerCase()) ?? false).toList();
      state = _Success(filtered);
    }
  }
}
