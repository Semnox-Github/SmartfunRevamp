import 'package:flutter/material.dart';
import 'package:focus_widget/focus_widget.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/text_style.dart';

class SemnoxTextFormField extends StatelessWidget {
  const SemnoxTextFormField({
    Key? key,
    required this.properties,
    this.prefix,
    this.suffix,
    this.enabled = true,
    this.position = LabelPosition.top,
    this.textAlign = TextAlign.start,
    this.fillColor,
  }) : super(key: key);
  final SemnoxTextFieldProperties properties;
  final Widget? prefix;
  final Widget? suffix;
  final bool enabled;
  final Color? fillColor;
  final TextAlign textAlign;
  final LabelPosition position;
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !enabled,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (properties.label != null && position == LabelPosition.top) ...{
              SemnoxText.bodyMed2(text: properties.label ?? ""),
              SizedBox(
                height: SemnoxPadding.mediumSpace(context),
              )
            },
            FocusWidget(
              focusNode: properties.focusNode,
              child: TextFormField(
                textAlign: textAlign,
                style: SemnoxTextStyle.bodyTextRegular1(context),
                focusNode: properties.focusNode,
                controller: properties.textEditingController,
                obscureText: properties.isObscured,
                validator: properties.validate,
                keyboardType: properties.keyboardType,
                maxLines: properties.maxLines,
                decoration: InputDecoration(
                  hintText: properties.hintText,
                  filled: true,
                  fillColor: fillColor, //?? Colors.white,
                  isDense: true,
                  prefixIcon: prefix,
                  suffixIcon: suffix,
                  labelText: position == LabelPosition.inside
                      ? properties.label ?? ""
                      : null,
                  // border: OutlineInputBorder(
                  //   borderSide: BorderSide(width: 5),
                  // ),
                  // enabledBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(
                  //     width: 1,
                  //     color: SemnoxConstantColor.shadowColor(context),
                  //   ),
                  // )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
