import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/feedback/survey_details.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

final _optionSelectedProvider = StateProvider.autoDispose<Map<String, dynamic>>((ref) {
  return {};
});

class FeedbackValueOption extends ConsumerWidget {
  const FeedbackValueOption({
    super.key,
    required this.surveyDetail,
  });
  final SurveyDetails surveyDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionSelected = ref.watch(_optionSelectedProvider);
    final responseValues = surveyDetail.surveyQuestion.questionResponse.responseValues;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MulishText(text: surveyDetail.surveyQuestion.question),
        responseValues != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...responseValues.reversed.map((e) {
                    if (!optionSelected.containsKey(surveyDetail.surveyQuestion.question)) {
                      ref.read(_optionSelectedProvider.notifier).update((state) {
                        state.addAll({surveyDetail.surveyQuestion.question: null});
                        return state;
                      });
                    }
                    return Flexible(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: optionSelected[surveyDetail.surveyQuestion.question] == e.responseValue ? CustomColors.customOrange : Colors.grey.shade200,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        onPressed: () => ref.read(_optionSelectedProvider.notifier).update((state) {
                          final tempMap = Map<String, dynamic>.from(state);
                          tempMap[surveyDetail.surveyQuestion.question] = e.responseValue;
                          return tempMap;
                        }),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                          child: MulishText(
                            text: e.responseValue,
                            fontColor: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              )
            : Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: const TextField(
                  maxLines: 5,
                ),
              ),
      ],
    );
  }
}
