part of 'update_card_nickname_provider.dart';

@freezed
class UpdateCardNicknameState with _$UpdateCardNicknameState {
  const factory UpdateCardNicknameState.initial() = _Initial;
  const factory UpdateCardNicknameState.inProgress() = _InProgress;
  const factory UpdateCardNicknameState.success() = _Success;
  const factory UpdateCardNicknameState.error(String msg) = _Error;
}
