import 'package:flutter/material.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class BillDetailRow extends StatelessWidget {
  const BillDetailRow({
    Key? key,
    required this.description,
    required this.amount,
  }) : super(key: key);
  final String description;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MulishText(text: description),
          MulishText(text: amount),
        ],
      ),
    );
  }
}
