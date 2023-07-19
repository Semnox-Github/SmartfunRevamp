import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/feedback/survey_details.dart';
import 'package:semnox/core/domain/use_cases/feedback/get_feedback_actions_use_case.dart';

final surveyDetailsProvider = FutureProvider.autoDispose<List<SurveyDetails>>((ref) async {
  final GetFeedbackActionsUseCase getFeedbackActionsUseCase = Get.find<GetFeedbackActionsUseCase>();
  final response = await getFeedbackActionsUseCase();
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});
