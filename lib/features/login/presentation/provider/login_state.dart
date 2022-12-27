part of 'login_notifier.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.inProgress() = _InProgress;
  const factory LoginState.success() = _Success;
  const factory LoginState.error(String message) = _Error;
}
