part of 'notifications_provider.dart';

@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState.initial() = _Initial;
  const factory NotificationsState.inProgress() = _InProgress;
  const factory NotificationsState.success(Map<DateTime, List<NotificationsResponse>> notifications) = _Success;
  const factory NotificationsState.error(String message) = _Error;
}
