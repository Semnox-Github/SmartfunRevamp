part of 'select_location_provider.dart';

@freezed
class SelectLocationState with _$SelectLocationState {
  const factory SelectLocationState.initial() = _Initial;
  const factory SelectLocationState.inProgress() = _InProgress;
  const factory SelectLocationState.success(List<SiteViewDTO> sites) = _Success;
  const factory SelectLocationState.newContextSuccess(SiteViewDTO selectedSite) = _NewContextSuccess;
  const factory SelectLocationState.error(String message) = _Error;
  const factory SelectLocationState.siteSelected() = _SiteSelected;
}
