part of 'splash_screen_notifier.dart';

@freezed
class SplashScreenState with _$SplashScreenState {
  const factory SplashScreenState.initial() = _Initial;
  const factory SplashScreenState.inProgress() = _InProgress;
  const factory SplashScreenState.retrievedSplashImageURL(String? url) = _RetrievedSplashImageURL;
  const factory SplashScreenState.success() = _Success;
  const factory SplashScreenState.userAuthenticated() = _UserAuthenticated;
  const factory SplashScreenState.error(String message) = _Error;
}
