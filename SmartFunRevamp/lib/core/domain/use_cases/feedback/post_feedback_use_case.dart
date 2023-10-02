import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/entities/feedback/survey_request.dart';
import 'package:semnox/core/domain/repositories/feedback_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class PostFeedbackUseCase {
  final FeedbackRepository _repository;
  PostFeedbackUseCase(this._repository);
  Future<Either<Failure, void>> call(SurveyRequest request) async {
    return await _repository.postCustomerFeedback(request);
  }
}
