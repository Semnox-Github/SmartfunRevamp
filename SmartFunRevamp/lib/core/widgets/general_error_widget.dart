import 'package:flutter/material.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class GeneralErrorWidget extends StatelessWidget {
  const GeneralErrorWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.error,
          color: Colors.red,
          size: 20.0,
        ),
        MulishText(text: message)
      ],
    );
  }
}
