import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class SetupTextFormField extends StatelessWidget {
  const SetupTextFormField(
      {Key? key,
      required this.textFieldPropeties,
      required this.label,
      this.trailing})
      : super(key: key);
  final SemnoxTextFieldProperties textFieldPropeties;
  final String label;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return SemnoxFlatCard(
      padding: SemnoxPadding.ltbMediumPadding(context),
      color: SemnoxConstantColor.cardForeground(context),
      child: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                  border: InputBorder.none, isCollapsed: true)),
          child: SemnoxListTile(
            padding: EdgeInsets.zero,
            leading: SemnoxIcons.server.toIcon(),
            title: SemnoxText.bodyMed1(
              text: label,
            ),
            subtitle: Container(
                // constraints: BoxConstraints(
                //   maxWidth: 200.mapToIdealWidth(context),
                // ),
                child: SemnoxTextFormField(
              fillColor: Colors.transparent,
              properties: textFieldPropeties,

              // decoration: InputDecoration.collapsed(hintText: ""),
              // controller: textFieldPropeties.textEditingController ,
            )),
            trailing: trailing,
          ),
        ),
      ),
    );
  }
}
