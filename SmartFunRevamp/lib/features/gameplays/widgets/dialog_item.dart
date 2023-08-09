import 'package:flutter/material.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class DialogItem extends StatelessWidget {
  const DialogItem({
    super.key,
    required this.value,
    required this.title,
  });
  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        gradient: CustomGradients.linearGradient,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Card(
        color: Colors.white,
        elevation: 0.0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            MulishText(
              text: value,
              fontSize: 25,
              fontColor: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            MulishText(
              text: title,
              fontSize: 14,
              fontColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
