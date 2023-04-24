import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_execution_context_use_case.dart';
import 'package:semnox/core/domain/use_cases/select_location/get_all_sites_use_case.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';
part 'select_location_state.dart';
part 'select_location_provider.freezed.dart';

final selectLocationStateProvider = StateNotifierProvider<SelectLocationProvider, SelectLocationState>(
  (ref) => SelectLocationProvider(
    Get.find<GetAllSitesUseCase>(),
    Get.find<LocalDataSource>(),
    Get.find<GetExecutionContextUseCase>(),
  ),
);

final getAllSitesProvider = FutureProvider.autoDispose<List<SiteViewDTO>>((ref) async {
  final GetAllSitesUseCase getAllSitesUseCase = Get.find<GetAllSitesUseCase>();
  final response = await getAllSitesUseCase();
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});

class SelectLocationProvider extends StateNotifier<SelectLocationState> {
  final GetAllSitesUseCase _getAllSitesUseCase;
  final LocalDataSource _localDataSource;
  final GetExecutionContextUseCase _getExecutionContextUseCase;
  List<SiteViewDTO> _sites = [];
  SelectLocationProvider(this._getAllSitesUseCase, this._localDataSource, this._getExecutionContextUseCase) : super(const _Initial()) {
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

  void selectSite(SiteViewDTO selectedSite) async {
    state = const _InProgress();
    final response = await _getExecutionContextUseCase(selectedSite.siteId!);
    response.fold(
      (l) => state = _Error(l.message),
      (r) async {
        await _localDataSource.saveCustomClass(LocalDataSource.kSelectedSite, selectedSite.toJson());
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
