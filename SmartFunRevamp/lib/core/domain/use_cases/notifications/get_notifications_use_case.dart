import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/notifications/notifications_response.dart';
import 'package:semnox/core/domain/repositories/notifications_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetNotificationsUseCase {
  final NotificationsRepository _repository;
  GetNotificationsUseCase(this._repository);
  Future<Either<Failure, Map<DateTime, List<NotificationsResponse>>>> call(String userId) async {
    return await _repository.getNotifications(userId);
  }
}
