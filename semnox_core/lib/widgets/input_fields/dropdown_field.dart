import 'package:flutter/material.dart';
import 'package:focus_widget/focus_widget.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxDropdownField<T> extends StatelessWidget {
  const SemnoxDropdownField({
    Key? key,
    required this.properties,
    this.prefix,
    this.suffix,
    this.enabled = true,
    this.position = LabelPosition.top,
    this.fillColor,
  }) : super(key: key);

  final SemnoxDropdownProperties<T> properties;
  final Widget? prefix;
  final Widget? suffix;
  final bool enabled;
  final Color? fillColor;
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
            FocusWidget.builder(context, builder: (context, focusNode) {
              return StreamBuilder(
                  stream: properties.valueChangeStream,
                  builder: (context, snapshot) {
                    return DropdownButtonFormField(
                      focusNode: focusNode,
                      items: properties.items,
                      onChanged: (dynamic value) {
                        properties.setInitialValue(value);
                      },
                      value: properties.value,
                      validator: properties.validate,
                      decoration: InputDecoration(
                          enabled: properties.enabled,
                          prefixIcon: prefix,
                          isDense: true,
                          filled: true,
                          fillColor: fillColor, //?? Colors.white,
                          suffixIcon: suffix,
                          labelText: position == LabelPosition.inside
                              ? properties.label ?? ""
                              : null,
                          border: OutlineInputBorder()),
                    );
                  });
            })
          ],
        ),
      ),
    );
  }
}
