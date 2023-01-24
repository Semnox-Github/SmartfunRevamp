import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxPopUpTwoButtons extends StatelessWidget {
  const SemnoxPopUpTwoButtons({
    Key? key,
    required this.outlineButtonText,
    required this.filledButtonText,
    this.onOutlineButtonPressed,
    this.onFilledButtonPressed,
    this.flex1 = 1,
    this.flex2 = 1,
    this.borderRadius,
    this.padding,
    this.disableShadow = false,
    this.sidePadding,
  }) : super(key: key);
  final String outlineButtonText;
  final String filledButtonText;
  final int flex1;
  final int flex2;
  final bool disableShadow;
  final EdgeInsets? sidePadding;
  final EdgeInsets? padding;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onOutlineButtonPressed;
  final VoidCallback? onFilledButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? EdgeInsets.only(top: SemnoxPadding.mediumSpace(context)),
      child: SemnoxElevatedCard(
          padding: sidePadding,
          disableShadow: disableShadow,
          borderRadius: borderRadius,
          child: Row(
            children: [
              Expanded(
                flex: flex1,
                child: SemnoxOutlineButton(
                  child: SemnoxText(
                    text: outlineButtonText,
                  ),
                  onPressed: onOutlineButtonPressed,
                ),
              ),
              SizedBox(
                width: SemnoxPadding.mediumSpace(context),
              ),
              Expanded(
                flex: flex2,
                child: SemnoxFlatButton(
                  child: SemnoxText(
                    text: filledButtonText,
                  ),
                  onPressed: onFilledButtonPressed,
                ),
              ),
            ],
          )),
    );
  }
}

class SemnoxpopupSingleButton extends StatelessWidget {
  const SemnoxpopupSingleButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.padding,
  }) : super(key: key);
  final String label;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? EdgeInsets.only(top: SemnoxPadding.mediumSpace(context)),
      child: SemnoxElevatedCard(
        borderRadius: BorderRadius.zero,
        child: Row(
          children: [
            Expanded(
              child: SemnoxFlatButton(
                child: SemnoxText(
                  text: label,
                ),
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
