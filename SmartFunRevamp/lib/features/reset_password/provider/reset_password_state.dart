part of 'reset_password_provider.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.initial() = _Initial;
  const factory ResetPasswordState.inProgress() = _InProgress;
  const factory ResetPasswordState.success() = _Success;
  const factory ResetPasswordState.error(String message) = _Error;
}
