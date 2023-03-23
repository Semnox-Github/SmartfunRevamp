import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/notifications/notifications_response.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, Map<DateTime, List<NotificationsResponse>>>> getNotifications(String userId);
}
