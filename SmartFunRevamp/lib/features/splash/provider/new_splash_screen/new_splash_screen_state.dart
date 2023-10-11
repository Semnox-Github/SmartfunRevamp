part of 'new_splash_screen_notifier.dart';

@freezed
class NewSplashScreenState with _$NewSplashScreenState {
  const factory NewSplashScreenState.inProgress() = _InProgress;
  const factory NewSplashScreenState.error(String message) = _Error;
  const factory NewSplashScreenState.retrievedSplashImageURL(String? url) = _RetrievedSplashImageURL;
  const factory NewSplashScreenState.success({
    required HomePageCMSResponse homePageCMSResponse,
    required LanguageContainerDTO languageContainerDTO,
    required SiteViewDTO siteViewDTO,
    required ParafaitDefaultsResponse parafaitDefaultsResponse,
    required bool needsSiteSelection,
    required CustomerDTO? customer,
  }) = _Success;
}
