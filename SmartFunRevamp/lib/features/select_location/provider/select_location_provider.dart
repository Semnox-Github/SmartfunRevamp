import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_execution_context_use_case.dart';
import 'package:semnox/core/domain/use_cases/select_location/get_all_sites_use_case.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';
part 'select_location_state.dart';
part 'select_location_provider.freezed.dart';

final getAllSitesProvider = FutureProvider<List<SiteViewDTO>>((ref) async {
  final GetAllSitesUseCase getAllSitesUseCase = Get.find<GetAllSitesUseCase>();
  final response = await getAllSitesUseCase();
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});
final selectLocationStateProvider = StateNotifierProvider.autoDispose<SelectLocationProvider, SelectLocationState>(
  (ref) {
    final sites = ref.watch(getAllSitesProvider).asData?.value;
    return SelectLocationProvider(
      Get.find<LocalDataSource>(),
      Get.find<GetExecutionContextUseCase>(),
      sites ?? [],
    );
  },
);

class SelectLocationProvider extends StateNotifier<SelectLocationState> {
  final LocalDataSource _localDataSource;
  final GetExecutionContextUseCase _getExecutionContextUseCase;
  final List<SiteViewDTO> _sites;
  SelectLocationProvider(this._localDataSource, this._getExecutionContextUseCase, this._sites) : super(_Success(_sites));

  void selectSite(SiteViewDTO selectedSite) async {
    state = const _InProgress();
    final response = await _getExecutionContextUseCase(selectedSite.siteId!);
    response.fold(
      (l) => state = _Error(l.message),
      (r) async {
        await _localDataSource.saveCustomClass(LocalDataSource.kSelectedSite, selectedSite.toJson());
        Get.replace<SmartFunApi>(SmartFunApi('', r));
        state = _NewContextSuccess(selectedSite);
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
