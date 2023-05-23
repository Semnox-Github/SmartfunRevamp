import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/feedback/survey_details.dart';
import 'package:semnox/core/domain/repositories/feedback_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final SmartFunApi _api;

  FeedbackRepositoryImpl(this._api);

  @override
  Future<Either<Failure, List<SurveyQuestion>>> getFeedbackActions() async {
    try {
      final response = await _api.getCustomerFeedbackActions();
      return Right(response.data.first.surveyDetails);
    } on DioError catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(ServerFailure('Not Found'));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(message['data']));
    } catch (e) {
      rethrow;
    }
  }
}
