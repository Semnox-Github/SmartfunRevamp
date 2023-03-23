import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/repositories/notifications_repository_impl.dart';
import 'package:semnox/core/domain/repositories/notifications_repository.dart';
import 'package:semnox/core/domain/use_cases/notifications/get_notifications_use_case.dart';

void notificationsDependecies() {
  //Repository
  Get.lazyPut<NotificationsRepository>(() => NotificationsRepositoryImpl(Get.find()));

  //Use Cases
  Get.lazyPut<GetNotificationsUseCase>(() => GetNotificationsUseCase(Get.find()));
}
