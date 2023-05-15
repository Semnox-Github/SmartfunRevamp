part of 'link_card_provider.dart';

@freezed
class LinkCardState with _$LinkCardState {
  const factory LinkCardState.initial() = _Initial;
  const factory LinkCardState.inProgress() = _InProgress;
  const factory LinkCardState.success() = _Success;
  const factory LinkCardState.error(String msg) = _Error;
}
