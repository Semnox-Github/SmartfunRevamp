import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/feedback/survey_details.dart';
import 'package:semnox/core/domain/entities/feedback/survey_request.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class FeedbackRepository {
  Future<Either<Failure, SurveyDetailsResponse>> getFeedbackActions();
  Future<Either<Failure, void>> postCustomerFeedback(SurveyRequest request);
}
