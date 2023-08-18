import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/core/enums/contact_enum.dart';
import 'package:semnox/features/account/provider/verify/verify_provider.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

import 'verify_button.dart';

class CustomVerifyTextField extends ConsumerStatefulWidget {
  const CustomVerifyTextField({
    Key? key,
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
    this.required = true,
  }) : super(key: key);
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
  final bool required;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomVerifyTextField();
}

class _CustomVerifyTextField extends ConsumerState<CustomVerifyTextField> {
  late bool emailVerifiedFlag;
  late bool phoneVerifiedFlag;

  @override
  void initState() {
    super.initState();
    emailVerifiedFlag = true;
    phoneVerifiedFlag = true;
  }

  callBackVerification() {
    switch (widget.contactType.valueString) {
      case "Phone":
        phoneVerifiedFlag = true;
        break;
      case "Email":
        emailVerifiedFlag = true;
        break;
    }
    ref.invalidate(sendOtpStateProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      margin: widget.margins,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: GoogleFonts.mulish(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade700,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: widget.initialValue,
                        inputFormatters: widget.formatters,
                        onSaved: (newValue) => widget.onSaved(newValue!),
                        onChanged: (value) {
                          switch (widget.contactType.valueString) {
                            case "Phone":
                              setState(() {
                                phoneVerifiedFlag = false;
                              });
                              break;
                            case "Email":
                              setState(() {
                                emailVerifiedFlag = false;
                              });
                              break;
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty && widget.required) {
                            return SplashScreenNotifier.getLanguageLabel(
                                'Required');
                          } else if ((value!.isEmpty &&
                                  widget.contactType.valueString == "Email" &&
                                  !emailVerifiedFlag) ||
                              (value!.isEmpty &&
                                  widget.contactType.valueString == "Phone" &&
                                  !phoneVerifiedFlag)) {
                            return SplashScreenNotifier.getLanguageLabel(
                                'Please verify your ${widget.contactType.valueString}');
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
                          fillColor: widget.fillColor,
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                    ),
                    VerifyButton(
                        key: Key(widget.contactType.valueString),
                        contactType: widget.contactType,
                        phoneOrEmail: widget.phoneOrEmail,
                        isVerified: () {
                          callBackVerification();
                        }),
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
