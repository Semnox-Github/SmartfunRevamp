import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/feedback/survey_details.dart';
import 'package:semnox/core/errors/failures.dart';

abstract class FeedbackRepository {
  Future<Either<Failure, List<SurveyQuestion>>> getFeedbackActions();
}
