import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/sign_up/sign_up_entity.dart';
import 'package:semnox/core/domain/entities/sign_up/user_metadata.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_user_metadata_use_case.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/features/login/pages/login_page.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/login/widgets/social_logins_container.dart';
import 'package:semnox/features/sign_up/pages/privacy_policy_page.dart';
import 'package:semnox/features/sign_up/pages/terms_of_use_page.dart';
import 'package:semnox/features/sign_up/provider/sign_up_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

final uiMetaDataProvider = FutureProvider<List<CustomerUIMetaData>>((ref) async {
  final getUiMetaData = Get.find<GetUserMetaDataUseCase>();
  final response = await getUiMetaData();
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

  // Initially password is obscure
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    
    final isPasswordDisabled = ref.watch(isPasswordDisabledProvider);
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
        success: () {
          context.loaderOverlay.hide();
          Navigator.pushReplacementNamed(context, Routes.kHomePage);
        },
        selectLocationNeeded: () {
          context.loaderOverlay.hide();
          Navigator.pushReplacementNamed(context, Routes.kEnableLocation);
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
        backgroundColor: CustomColors.customLigthBlue,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColors.customBlue,
          ),
        ),
        centerTitle: false,
        title: Text(
          SplashScreenNotifier.getLanguageLabel('Set Your Account'),
          style: const TextStyle(
            color: CustomColors.customBlue,
          ),
        ),
        elevation: 0.0,
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
                  SplashScreenNotifier.getLanguageLabel('Hi There, Complete the following details to setup your accound and coitinue using Smartfun App.'),
                ),
                const SizedBox(height: 20.0),
                metaData.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
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
                                value: request[field.customerFieldName],
                                items: List<String>.from(field.customerFieldValues).map((title) {
                                  return DropdownMenuItem<String>(
                                    value: title,
                                    child: Text(SplashScreenNotifier.getLanguageLabel(title)),
                                  );
                                }).toList(),
                                onChanged: (title) => request[field.customerFieldName] = title,
                              ),
                            ],
                          );
                        }
                        return CustomTextField(
                          onSaved: (value) => request[field.customerFieldName] = value,
                          label: '${SplashScreenNotifier.getLanguageLabel(field.entityFieldCaption)}${field.validationType == "M" ? "*" : ""}',
                          margins: const EdgeInsets.symmetric(vertical: 10.0),
                          required: field.validationType == "M",
                        );
                      }).toList(),
                    );
                  },
                ),
                if(!isPasswordDisabled)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${SplashScreenNotifier.getLanguageLabel("Password")}*",
                        style: GoogleFonts.mulish(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: !_passwordVisible,//This will obscure text dynamically
                        decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            // Here is key idea
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                      _passwordVisible = !_passwordVisible;
                                  });
                                },
                            ),
                          ),
                        onChanged: (password) { 
                          setState(() {
                            userPassword = password;
                          });                      
                        },
                      ),
                      const SizedBox(height: 10.0),
                    ]
                  )                  
                ,
                configExecutionContext.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TermsOfUsePage(),
                                ),
                              );
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PrivacyPolicyPage(),
                              ),
                            );
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
                      ref.read(signUpNotifier.notifier).signUpUser(SignUpEntity.fromMetaData(request), userPassword);
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
      ),
    );
  }
}
