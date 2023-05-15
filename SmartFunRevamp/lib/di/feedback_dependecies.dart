import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/repositories/feedback_repository_impl.dart';
import 'package:semnox/core/domain/repositories/feedback_repository.dart';
import 'package:semnox/core/domain/use_cases/feedback/get_feedback_actions_use_case.dart';

void feedbackDependencies() {
  //Repository
  Get.lazyPut<FeedbackRepository>(() => FeedbackRepositoryImpl(Get.find()));

  //Use Cases
  Get.lazyPut<GetFeedbackActionsUseCase>(() => GetFeedbackActionsUseCase(Get.find()));
}
