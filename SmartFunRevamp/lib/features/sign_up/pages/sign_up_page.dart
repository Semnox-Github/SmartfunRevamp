import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/sign_up/sign_up_entity.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/custom_date_picker.dart';
import 'package:semnox/core/widgets/password_field.dart';
import 'package:semnox/features/sign_up/provider/sign_up_notifier.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SignUpEntity request = SignUpEntity();
    ref.listen<SignUpState>(signUpNotifier, (_, next) {
      next.maybeWhen(
        inProgress: () => context.loaderOverlay.show(),
        orElse: () => context.loaderOverlay.hide(),
        success: () {
          context.loaderOverlay.hide();
          Navigator.pop(context);
        },
        error: (message) {
          context.loaderOverlay.hide();
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            title: 'Error',
            desc: message,
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        },
      );
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.customLigthBlue,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColors.customBlue,
          ),
        ),
        centerTitle: false,
        title: const Text(
          'Set Your Account',
          style: TextStyle(
            color: CustomColors.customBlue,
          ),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                const Text(
                  'Hi There,\nComplete the following details to setup your account and continue using Smartfun app.',
                ),
                const SizedBox(height: 20.0),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Title',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButtonFormField<String>(
                      value: request.title,
                      items: ['Mr.', 'Mrs.', 'Ms.'].map((title) {
                        return DropdownMenuItem<String>(
                          value: title,
                          child: Text(title),
                        );
                      }).toList(),
                      onChanged: (title) => request.title = title,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  onSaved: (firstname) => request.firstName = firstname,
                  label: 'First Name',
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  onSaved: (lastName) => request.lastName = lastName,
                  label: 'Last Name',
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  onSaved: (email) {
                    request.email = email;
                    request.username = email;
                  },
                  label: 'Email Address',
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  onSaved: (phoneNumber) => request.phoneNumber = phoneNumber,
                  label: 'Mobile Number',
                  inputType: TextInputType.phone,
                ),
                const SizedBox(height: 20.0),
                CustomDatePicker(
                  labelText: 'Date of birth',
                  format: 'MM-dd-yyyy',
                  onItemSelected: (dob) => request.dateOfBirth = dob.toIso8601String(),
                ),
                const SizedBox(height: 20.0),
                PasswordField(
                  onSaved: (password) => request.password = password,
                  borderColor: Colors.black,
                  fillColor: Colors.transparent,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: CustomColors.customLigthGray,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Or Continue with social Logins',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(
                            'assets/login/google.svg',
                          ),
                          SvgPicture.asset(
                            'assets/login/apple.svg',
                          ),
                          SvgPicture.asset(
                            'assets/login/facebook.svg',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w600,
                      color: CustomColors.customLigthBlack,
                    ),
                    children: const [
                      TextSpan(
                        text: 'By Logging in you agree to our ',
                      ),
                      TextSpan(
                        text: 'Terms of Service ',
                        style: TextStyle(
                          color: CustomColors.hardOrange,
                        ),
                      ),
                      TextSpan(
                        text: 'and ',
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: CustomColors.hardOrange,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                CustomButton(
                  onTap: () {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();
                      ref.read(signUpNotifier.notifier).signUpUser(request);
                    }
                  },
                  label: 'SIGN UP',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.onSaved,
    required this.label,
    this.inputType = TextInputType.name,
    this.fillColor = Colors.transparent,
    this.formatters,
    this.initialValue,
  }) : super(key: key);
  final Function(String) onSaved;
  final String label;
  final String? initialValue;
  final TextInputType inputType;
  final Color fillColor;
  final List<TextInputFormatter>? formatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
        TextFormField(
          initialValue: initialValue,
          inputFormatters: formatters,
          onSaved: (newValue) => onSaved(newValue!),
          validator: (value) => value!.isEmpty ? 'Required' : null,
          cursorColor: Colors.black,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            isDense: true,
            fillColor: fillColor,
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}
