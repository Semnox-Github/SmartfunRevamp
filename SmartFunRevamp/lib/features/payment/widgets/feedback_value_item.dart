import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/feedback/survey_details.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class FeedbackValueOption extends StatefulWidget {
  const FeedbackValueOption({super.key, required this.responseValues});
  final List<CustomerFeedbackResponseValues> responseValues;

  @override
  State<FeedbackValueOption> createState() => _FeedbackValueOptionState();
}

class _FeedbackValueOptionState extends State<FeedbackValueOption> {
  String selected = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.responseValues.reversed.map(
          (e) {
            return FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: selected == e.responseValue ? CustomColors.customOrange : Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
              ),
              onPressed: () {
                setState(() {
                  selected = e.responseValue;
                });
              },
              child: MulishText(
                text: e.responseValue,
                fontColor: Colors.black,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
