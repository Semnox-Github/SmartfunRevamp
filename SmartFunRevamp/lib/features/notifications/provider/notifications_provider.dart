import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/notifications/notifications_response.dart';
import 'package:semnox/core/domain/use_cases/notifications/get_notifications_use_case.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
part 'notifications_state.dart';
part 'notifications_provider.freezed.dart';

class NotificationsProvider {
  static final notificationsStateProvider = StateNotifierProvider<NotificationsStateNotifier, NotificationsState>(
    (ref) => NotificationsStateNotifier(
      Get.find<GetNotificationsUseCase>(),
    ),
  );
}

class NotificationsStateNotifier extends StateNotifier<NotificationsState> {
  final GetNotificationsUseCase _getNotificationsUseCase;

  NotificationsStateNotifier(this._getNotificationsUseCase) : super(const _InProgress()) {
    getNotifications();
  }
  Map<DateTime, List<NotificationsResponse>> _notifications = {};

  void getNotifications() async {
    final userId = Get.find<CustomerDTO>().id;
    final response = await _getNotificationsUseCase(userId.toString());
    state = response.fold(
      (l) => _Error(l.message),
      (r) {
        _notifications = r;
        return _Success(_notifications);
      },
    );
  }

  void removeNotification(NotificationsResponse noti) {
    state = const _InProgress();
    _notifications.forEach((key, value) {
      if (value.contains(noti)) {
        value.remove(noti);
      }
    });
    _notifications.removeWhere((key, value) => value.isEmpty);
    state = _Success(_notifications);
  }

  void removeAll() {
    state = const _InProgress();
    _notifications.clear();
    state = _Success(_notifications);
  }
}
