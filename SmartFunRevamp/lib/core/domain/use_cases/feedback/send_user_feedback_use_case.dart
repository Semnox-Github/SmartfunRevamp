import 'package:dartz/dartz.dart';
import 'package:semnox/core/domain/repositories/feedback_repository.dart';
import 'package:semnox/core/errors/failures.dart';

class GetFeedbackActionsUseCase {
  final FeedbackRepository _repository;
  GetFeedbackActionsUseCase(this._repository);
  Future<Either<Failure, void>> call() async {
    return await _repository.postCustomerFeedback();
  }
}
