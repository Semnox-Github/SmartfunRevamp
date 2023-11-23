import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:semnox/core/domain/entities/feedback/survey_details.dart';
import 'package:semnox/core/domain/entities/feedback/survey_request.dart';
import 'package:semnox/core/domain/use_cases/feedback/get_feedback_actions_use_case.dart';
import 'package:semnox/core/domain/use_cases/feedback/post_feedback_use_case.dart';
import 'package:semnox/features/buy_a_card/pages/estimated_transaction_page.dart';
import 'package:semnox/features/payment/widgets/feedback_value_item.dart';

final surveyDetailsProvider = FutureProvider.autoDispose<SurveyDetailsResponse>((ref) async {
  final GetFeedbackActionsUseCase getFeedbackActionsUseCase = Get.find<GetFeedbackActionsUseCase>();
  final response = await getFeedbackActionsUseCase();
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});

final postFeedback = FutureProvider.autoDispose((ref) async {
  final selection = ref.watch(optionSelectedProvider);
  final PostFeedbackUseCase postFeedbackUseCase = Get.find<PostFeedbackUseCase>();
  final date = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now());
  final transactionId = ref.watch(currentTransactionIdProvider);

  final surveyRequest = SurveyRequest(
    customerFeedbackSurveyDataDTOList: [
      ...selection.entries.where((element) => element.value != null).map(
        (e) {
          return CustomerFeedbackSurveyDataDTO(
            e.key.custFbSurveyDetailId,
            (e.value is String) ? null : (e.value as CustomerFeedbackResponseValues).custFbResponseValueId,
            (e.value is String) ? (e.value as String) : null,
            date,
          );
        },
      ).toList(),
    ],
    customerFeedbackSurveyMappingDTOList: [
      CustomerFeedbackSurveyMappingDTO(
        transactionId ?? -1,
        date,
      ),
    ],
  );
  if (surveyRequest.customerFeedbackSurveyDataDTOList.isEmpty) {
    return;
  }
  final response = await postFeedbackUseCase(surveyRequest);
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});
