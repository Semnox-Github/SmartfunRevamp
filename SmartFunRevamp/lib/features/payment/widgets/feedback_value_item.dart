import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/feedback/survey_details.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

final optionSelectedProvider =
    StateProvider.autoDispose<Map<SurveyDetails, dynamic>>((ref) {
  return {};
});

class FeedbackValueOption extends ConsumerWidget {
  final SurveyDetails surveyDetail;
  const FeedbackValueOption({
    super.key,
    required this.surveyDetail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionSelected = ref.watch(optionSelectedProvider);
    final responseValues =
        surveyDetail.surveyQuestion.questionResponse.responseValues;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MulishText(text: surveyDetail.surveyQuestion.question),
        responseValues != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ...responseValues.reversed.map((e) {
                    if (!optionSelected.containsKey(surveyDetail)) {
                      ref.read(optionSelectedProvider.notifier).update((state) {
                        state.addAll({surveyDetail: null});
                        return state;
                      });
                    }
                    if (!e.image.isNullOrEmpty()) {
                      return GestureDetector(
                        onTap: () {
                          ref
                              .read(optionSelectedProvider.notifier)
                              .update((state) {
                            final tempMap =
                                Map<SurveyDetails, dynamic>.from(state);
                            tempMap[surveyDetail] = e;
                            return tempMap;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                            color: optionSelected[surveyDetail] == e
                                ? CustomColors.customOrange
                                : Colors.transparent,
                          ),
                          child: Opacity(
                            opacity:
                                optionSelected[surveyDetail] == e ? 1.0 : 0.5,
                            child: Image.memory(
                              e.base64Image!,
                              scale: 2.0,
                              // color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }

                    return Flexible(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: optionSelected[surveyDetail] == e
                              ? CustomColors.customOrange
                              : Colors.grey.shade200,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        onPressed: () => ref
                            .read(optionSelectedProvider.notifier)
                            .update((state) {
                          final tempMap =
                              Map<SurveyDetails, dynamic>.from(state);
                          tempMap[surveyDetail] = e;
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
                child: TextField(
                  maxLines: 5,
                  onChanged: (value) {
                    ref.read(optionSelectedProvider.notifier).update((state) {
                      final tempMap = Map<SurveyDetails, dynamic>.from(state);
                      tempMap[surveyDetail] = value;
                      return tempMap;
                    });
                  },
                ),
              ),
      ],
    );
  }
}
