import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/core/enums/contact_enum.dart';

import 'verify_button.dart';

class CustomVerifyTextField extends ConsumerWidget {
  const CustomVerifyTextField({
    super.key,
    required this.onSaved,
    required this.label,
    required this.contactType,
    required this.phoneOrEmail,
    this.padding = EdgeInsets.zero,
    this.margins = EdgeInsets.zero,
    this.inputType = TextInputType.name,
    this.fillColor = Colors.transparent,
    this.formatters,
    this.initialValue,
  });
  final Function(String) onSaved;
  final String label;
  final String? initialValue;
  final TextInputType inputType;
  final Color fillColor;
  final List<TextInputFormatter>? formatters;
  final EdgeInsets padding;
  final EdgeInsets margins;
  final ContactType contactType;
  final String phoneOrEmail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool emailVerifiedFlag = false;
    bool phoneVerifiedFlag = false;
    return Container(
      padding: padding,
      margin: margins,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.mulish(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: contactType.valueString == "Phone" && phoneVerifiedFlag ? Colors.green : Colors.grey.shade700 ,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: initialValue,
                        inputFormatters: formatters,
                        onSaved: (newValue) => onSaved(newValue!),
                        onChanged: (value) {
                          switch (contactType.valueString) {
                            case "Phone":
                              phoneVerifiedFlag = false;
                              break;
                            case "Email":
                              emailVerifiedFlag = false;
                              break;
                           }
                        },
                        validator: (value) {
                          if (value!.isEmpty) { 
                            return 'Required';
                          } else if ((contactType.valueString == "Email" && !emailVerifiedFlag) || (contactType.valueString == "Phone" && !phoneVerifiedFlag)){
                            return 'Please verify your ${contactType.valueString}';
                          } else {
                            return null;
                          }
                        }, 
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          isDense: true,
                          fillColor: fillColor,
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                    ),
                    VerifyButton(
                      key: Key(contactType.valueString),
                      contactType: contactType,
                      phoneOrEmail: phoneOrEmail,
                      isVerified: () {
                        switch (contactType.valueString) {
                          case "Phone":
                            phoneVerifiedFlag = true;
                            break;
                          case "Email":
                            emailVerifiedFlag = true;
                            break;
                        }
                        //verifiedFlag = true;
                      }
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
