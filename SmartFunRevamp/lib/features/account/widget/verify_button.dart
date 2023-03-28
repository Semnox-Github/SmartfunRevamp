import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class VerifyButton extends StatefulWidget {
  const VerifyButton({super.key, required this.description});
  final String description;

  @override
  State<VerifyButton> createState() => _VerifyButtonState();
}

class _VerifyButtonState extends State<VerifyButton> {
  bool isVerified = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isVerified
          ? null
          : () {
              Dialogs.verifyDialog(
                context,
                () {
                  setState(() {
                    isVerified = true;
                  });
                },
                widget.description,
              );
            },
      child: MulishText(
        text: isVerified ? 'VERIFIED' : 'Verify',
        fontColor: isVerified ? Colors.green : CustomColors.hardOrange,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
