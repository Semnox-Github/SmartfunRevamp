part of 'sign_up_notifier.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = _Initial;
  const factory SignUpState.inProgress() = _InProgress;
  const factory SignUpState.success() = _Success;
  const factory SignUpState.error(String message) = _Error;
}
