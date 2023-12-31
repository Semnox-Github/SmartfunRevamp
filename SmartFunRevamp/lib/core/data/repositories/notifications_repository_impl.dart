import 'package:flutter/foundation.dart';
import 'package:semnox/core/api/smart_fun_api.dart';

import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/notifications/notifications_response.dart';
import 'package:semnox/core/domain/repositories/notifications_repository.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:collection/collection.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final SmartFunApi _api;

  NotificationsRepositoryImpl(this._api);

  @override
  Future<Either<Failure, Map<DateTime, List<NotificationsResponse>>>> getNotifications(String userId) async {
    try {
      final toDate = DateTime.now().subtract(const Duration(days: 365));
      final fromDate = toDate.subtract(const Duration(days: 30));
      final response = await _api.getAllNotifications(
        fromDate.formatDate('yyyy-MM-dd'),
        toDate.formatDate('yyyy-MM-dd'),
        userId,
      );

      return Right(response.data.groupListsBy((element) => element.sendDate));
    } on Exception catch (e) {
      if (kDebugMode) {
        final today = DateTime.now();
        final testList = [
          NotificationsResponse(today, 'Upcoming Booking in 1 hr', 'The Movie starts at 1:15pm, in an hour', true),
          NotificationsResponse(today.subtract(const Duration(days: 1)), 'Upcoming Booking in 1 hr',
              'The Movie starts at 1:15pm, in an hour', true),
          NotificationsResponse(today.subtract(const Duration(days: 50)), 'Upcoming Booking in 1 hr',
              'The Movie starts at 1:15pm, in an hour', false),
          NotificationsResponse(today.subtract(const Duration(days: 50)), 'Upcoming Booking in 1 hr',
              'The Movie starts at 1:15pm, in an hour', false),
          NotificationsResponse(today.subtract(const Duration(days: 50)), 'Upcoming Booking in 1 hr',
              'The Movie starts at 1:15pm, in an hour', false),
          NotificationsResponse(today.subtract(const Duration(days: 50)), 'Upcoming Booking in 1 hr',
              'The Movie starts at 1:15pm, in an hour', false),
          NotificationsResponse(today.subtract(const Duration(days: 50)), 'Upcoming Booking in 1 hr',
              'The Movie starts at 1:15pm, in an hour', false),
        ];
        final notificationsGrouped = testList.groupListsBy((element) => element.sendDate);
        return Right(notificationsGrouped);
      }
      return Left(e.handleException());
    }
  }
}
