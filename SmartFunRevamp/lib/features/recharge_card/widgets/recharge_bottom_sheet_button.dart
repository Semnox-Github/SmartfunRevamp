import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/widgets/custom_button.dart';

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton(
      {Key? key, required this.label, required this.onTap, this.color})
      : super(key: key);
  final String label;
  final Function() onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.white,
      elevation: 20.0,
      child: Container(
        padding: const EdgeInsets.all(25.0),
        child: Consumer(
          builder: (context, ref, child) {
            return CustomButton(
              onTap: onTap,
              label: label,
            );
          },
        ),
      ),
    );
  }
}
