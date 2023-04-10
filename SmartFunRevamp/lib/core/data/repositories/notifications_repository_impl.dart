import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
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
      final toDate = DateTime.now();
      final fromDate = DateTime.now().subtract(const Duration(days: 365));
      final response = await _api.getAllNotifications(
        userId,
        toDate: toDate.formatDate('yyyy-MM-dd'),
        fromDate: fromDate.formatDate('yyyy-MM-dd'),
      );

      return Right(response.data.groupListsBy((element) => element.sendDate));
    } on DioError catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      if (kDebugMode) {
        final today = DateTime.now();
        final testList = [
          NotificationsResponse(today, 'Upcoming Booking in 1 hr', 'The Movie starts at 1:15pm, in an hour', true),
          NotificationsResponse(today.subtract(const Duration(days: 1)), 'Upcoming Booking in 1 hr', 'The Movie starts at 1:15pm, in an hour', true),
          NotificationsResponse(today.subtract(const Duration(days: 50)), 'Upcoming Booking in 1 hr', 'The Movie starts at 1:15pm, in an hour', false),
          NotificationsResponse(today.subtract(const Duration(days: 50)), 'Upcoming Booking in 1 hr', 'The Movie starts at 1:15pm, in an hour', false),
          NotificationsResponse(today.subtract(const Duration(days: 50)), 'Upcoming Booking in 1 hr', 'The Movie starts at 1:15pm, in an hour', false),
          NotificationsResponse(today.subtract(const Duration(days: 50)), 'Upcoming Booking in 1 hr', 'The Movie starts at 1:15pm, in an hour', false),
          NotificationsResponse(today.subtract(const Duration(days: 50)), 'Upcoming Booking in 1 hr', 'The Movie starts at 1:15pm, in an hour', false),
        ];
        final notificationsGrouped = testList.groupListsBy((element) => element.sendDate);
        return Right(notificationsGrouped);
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    } catch (e) {
      Logger().e(e);
      return Left(ServerFailure(''));
    }
  }
}
