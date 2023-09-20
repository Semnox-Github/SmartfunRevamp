import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/data.dart';
import 'package:semnox/core/domain/entities/feedback/survey_details.dart';
import 'package:semnox/core/domain/entities/feedback/survey_request.dart';
import 'package:semnox/core/domain/repositories/feedback_repository.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final SmartFunApi _api;

  FeedbackRepositoryImpl(this._api);
  @override
  Future<Either<Failure, List<SurveyDetails>>> getFeedbackActions() async {
    try {
      // final response = await _api.getCustomerFeedbackActions();
      final String response =
          await rootBundle.loadString('assets/json/feedback_response.json');
      final data = (await json.decode(response)) as Map<String, dynamic>;
      final info = ListDataWrapper.fromJson(
          data,
          (json) =>
              SurveyDetailsResponse.fromJson(json as Map<String, dynamic>));

      for (var element in info.data.first.surveyDetails) {
        for (var t in element.surveyQuestion.questionResponse.responseValues ??
            <CustomerFeedbackResponseValues>[]) {
          if (t.image != null) {
            t.base64Image = base64Decode(t.image!);
          }
        }
      }
      return Right(info.data.first.surveyDetails);
    } on DioException catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(
            ServerFailure(SplashScreenNotifier.getLanguageLabel('Not Found')));
      }
      final message = json.decode(e.response.toString());
      return Left(ServerFailure(
          SplashScreenNotifier.getLanguageLabel(message['data'])));
    } catch (e, s) {
      Logger().e("Error:", e, s);
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> postCustomerFeedback(
      SurveyRequest request) async {
    try {
      await _api.sendCustomerFeedback({
        "data": [
          request.toJson(),
        ]
      });
      return const Right(null);
    } on DioException catch (e) {
      Logger().e(e);
      if (e.response?.statusCode == 404) {
        return Left(
          ServerFailure(
            SplashScreenNotifier.getLanguageLabel('Not Found'),
          ),
        );
      }
      final message = json.decode(e.response.toString());
      return Left(
        ServerFailure(
          SplashScreenNotifier.getLanguageLabel(
            message['data'],
          ),
        ),
      );
    } catch (e) {
      Logger().e(e);
      return Left(ServerFailure(''));
    }
  }
}
