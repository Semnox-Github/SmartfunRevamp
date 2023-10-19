import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/sign_up/sign_up_entity.dart';
import 'package:semnox/core/domain/entities/sign_up/user_metadata.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_user_metadata_use_case.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/custom_date_picker.dart';
import 'package:semnox/features/login/pages/login_page.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/login/widgets/social_logins_container.dart';
import 'package:semnox/features/sign_up/pages/web_view_page.dart';
import 'package:semnox/features/sign_up/provider/sign_up_notifier.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

final uiMetaDataProvider = FutureProvider<List<CustomerUIMetaData>>((ref) async {
  final getUiMetaData = Get.find<GetUserMetaDataUseCase>();
  final siteId = ref.watch(masterSiteProvider)?.siteId;
  final response = await getUiMetaData(siteId ?? 1010);
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPage();
}

class _SignUpPage extends ConsumerState<SignUpPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  Map<String, dynamic> request = {};
  String? userPassword;

  @override
  Widget build(BuildContext context) {
    final isPasswordDisabled = ref.watch(isPasswordDisabledProvider);
    final externalUrls = ref.watch(newHomePageCMSProvider)?.externalUrls;
    ref.listen<SignUpState>(signUpNotifier, (_, next) {
      next.maybeWhen(
        inProgress: () => context.loaderOverlay.show(),
        orElse: () => context.loaderOverlay.hide(),
        success: (signUpEntity) {
          if (isPasswordDisabled) {
            ref.read(loginProvider.notifier).loginUserWithOTP(signUpEntity.email ?? '');
          } else {
            ref.read(loginProvider.notifier).loginUser(signUpEntity.email!, signUpEntity.password!);
          }
        },
        error: (message) {
          context.loaderOverlay.hide();
          Dialogs.showErrorMessage(context, message);
        },
      );
    });
    ref.listen<LoginState>(loginProvider, (_, next) {
      next.maybeWhen(
        inProgress: () => context.loaderOverlay.show(),
        otpGenerated: () {
          context.loaderOverlay.hide();
          Navigator.pushNamed(context, Routes.kVerifyOTP);
        },
        orElse: () => context.loaderOverlay.hide(),
        success: (user) {
          context.loaderOverlay.hide();
          Navigator.pushReplacementNamed(context, Routes.kHomePage);
          ref.read(userProvider.notifier).update((_) => user);
        },
        customerVerificationNeeded: () {
          context.loaderOverlay.hide();
          Navigator.pushReplacementNamed(context, Routes.kCustomerVerification);
        },
        error: (message) {
          context.loaderOverlay.hide();
          Dialogs.showErrorMessage(context, message);
        },
      );
    });
    final metaData = ref.watch(uiMetaDataProvider);
    final configExecutionContext = ref.watch(preConfigProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColors.customBlue,
          ),
        ),
        title: Text(
          SplashScreenNotifier.getLanguageLabel('Set Your Account'),
          style: const TextStyle(
            color: CustomColors.customBlue,
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Text(
                  SplashScreenNotifier.getLanguageLabel(
                      'Hi There, Complete the following details to setup your account and continue using Smartfun App.'),
                ),
                const SizedBox(height: 20.0),
                metaData.when(
                  loading: () => const Center(child: CircularProgressIndicator.adaptive()),
                  error: (_, __) => const Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                  data: (metadata) {
                    return Column(
                      children: metadata.map((field) {
                        if (field.customerFieldValues is List) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                SplashScreenNotifier.getLanguageLabel(field.entityFieldCaption),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              DropdownButtonFormField<String>(
                                items: List<String>.from(field.customerFieldValues).map((title) {
                                  return DropdownMenuItem<String>(
                                    value: title,
                                    child: Text(SplashScreenNotifier.getLanguageLabel(title)),
                                  );
                                }).toList(),
                                onChanged: (title) => request[field.customerFieldName] = {
                                  "value": title,
                                  "customAttributeId": field.customAttributeId,
                                  "customerFieldType": field.customerFieldType
                                },
                              ),
                            ],
                          );
                        }
                        if (field.customerFieldName == "BIRTH_DATE" || field.customerFieldType == "DATE") {
                          return CustomDatePicker(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            labelText: SplashScreenNotifier.getLanguageLabel('Date of birth'),
                            format: 'MM-dd-yyyy',
                            onItemSelected: (dob) => request[field.customerFieldName] = {
                              "value": DateFormat('MM-dd-yyyy').format(dob).toString(),
                              "customAttributeId": field.customAttributeId,
                              "customerFieldType": field.customerFieldType
                            },
                            suffixIcon: const Icon(
                              Icons.date_range_outlined,
                              color: CustomColors.hardOrange,
                            ),
                          );
                        }
                        return CustomTextField(
                          onSaved: (value) => request[field.customerFieldName] = {
                            "value": value.toString(),
                            "customAttributeId": field.customAttributeId,
                            "customerFieldType": field.customerFieldType
                          },
                          label:
                              '${SplashScreenNotifier.getLanguageLabel(field.entityFieldCaption)}${field.validationType == "M" ? "*" : ""}',
                          margins: const EdgeInsets.symmetric(vertical: 10.0),
                          required: field.validationType == "M",
                          formatters: field.customerFieldName == "CONTACT_PHONE" || field.customerFieldType == "NUMBER"
                              ? [FilteringTextInputFormatter.digitsOnly]
                              : null,
                        );
                      }).toList(),
                    );
                  },
                ),
                if (!isPasswordDisabled)
                  Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    CustomPasswordTextField(
                      onSaved: (value) => request["PASSWORD"] = {
                        "value": value.toString(),
                        "customAttributeId": -1,
                        "customerFieldType": "TEXT"
                      },
                      label: '${SplashScreenNotifier.getLanguageLabel("Password")}*',
                      margins: const EdgeInsets.symmetric(vertical: 10.0),
                      required: true,
                    ),
                  ]),
                configExecutionContext.when(
                  loading: () => const Center(child: CircularProgressIndicator.adaptive()),
                  error: (error, _) {
                    if (error is Failure) {
                      return const Icon(Icons.error, color: Colors.red);
                    }
                    return Container();
                  },
                  data: (config) {
                    if (config.socialLayout) {
                      return const SocialLoginsContainer();
                    }
                    return Container();
                  },
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w600,
                      color: CustomColors.customLigthBlack,
                    ),
                    children: [
                      TextSpan(
                        text: '${SplashScreenNotifier.getLanguageLabel('By Logging in you agree to our')} ',
                      ),
                      TextSpan(
                          text: SplashScreenNotifier.getLanguageLabel('Terms of Service'),
                          style: const TextStyle(
                            color: CustomColors.hardOrange,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (externalUrls?.termsAndConditions != null &&
                                  externalUrls!.termsAndConditions.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewPage(
                                        url: externalUrls.termsAndConditions,
                                        title: SplashScreenNotifier.getLanguageLabel('Terms of Service')),
                                  ),
                                );
                              } else {
                                Fluttertoast.showToast(msg: "URL not configured");
                              }
                            }),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: SplashScreenNotifier.getLanguageLabel('and'),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: SplashScreenNotifier.getLanguageLabel('Privacy Policy'),
                        style: const TextStyle(
                          color: CustomColors.hardOrange,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (externalUrls?.privacyPolicy != null && externalUrls!.privacyPolicy.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewPage(
                                      url: externalUrls.privacyPolicy,
                                      title: SplashScreenNotifier.getLanguageLabel('Privacy Policy')),
                                ),
                              );
                            } else {
                              Fluttertoast.showToast(msg: "URL not configured");
                            }
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                CustomButton(
                  onTap: () {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();
                      ref.read(signUpNotifier.notifier).signUpUser(SignUpEntity.fromMetaData(request));
                    }
                  },
                  label: SplashScreenNotifier.getLanguageLabel('SIGN UP'),
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
    this.padding = EdgeInsets.zero,
    this.margins = EdgeInsets.zero,
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
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margins,
      child: Column(
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
            validator: (value) => value!.isEmpty && required ? SplashScreenNotifier.getLanguageLabel('Required') : null,
            cursorColor: Colors.black,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              isDense: true,
              fillColor: fillColor,
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          )
        ],
      ),
    );
  }
}

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({
    Key? key,
    required this.onSaved,
    required this.label,
    this.inputType = TextInputType.name,
    this.fillColor = Colors.transparent,
    this.formatters,
    this.initialValue,
    this.padding = EdgeInsets.zero,
    this.margins = EdgeInsets.zero,
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
  final bool required;

  @override
  State<CustomPasswordTextField> createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      margin: widget.margins,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          TextFormField(
            initialValue: widget.initialValue,
            inputFormatters: widget.formatters,
            onSaved: (newValue) => widget.onSaved(newValue!),
            validator: (value) =>
                value!.isEmpty && widget.required ? SplashScreenNotifier.getLanguageLabel('Required') : null,
            cursorColor: Colors.black,
            keyboardType: TextInputType.emailAddress,
            obscureText: !_passwordVisible, //This will obscure text dynamically
            decoration: InputDecoration(
              hintText: SplashScreenNotifier.getLanguageLabel('Enter your password'),
              // Here is key idea
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              isDense: true,
              fillColor: widget.fillColor,
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          )
        ],
      ),
    );
  }
}
