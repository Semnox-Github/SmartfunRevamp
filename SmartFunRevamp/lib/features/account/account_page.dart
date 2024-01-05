// ignore_for_file: unused_local_variable

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/enums/contact_enum.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/custom_date_picker.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/account/provider/update_account/update_account_provider.dart';
import 'package:semnox/features/home/widgets/more_view_widgets/round_rectangle_picture.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/sign_up/pages/sign_up_page.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:semnox_core/modules/customer/model/customer/custom_data_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

import '../../core/domain/entities/membership/membership_tier.dart';
import '../../core/domain/entities/sign_up/country_data.dart';
import '../../core/domain/entities/sign_up/user_metadataui.dart';
import 'widget/custom_verify_textfiel.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountPage();
}

class _AccountPage extends ConsumerState<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> request = {};

  @override
  Widget build(BuildContext context) {
    ref.watch(getStringForLocalization).maybeWhen(
      orElse: () {
        context.loaderOverlay.hide();
      },
      loading: () {
        context.loaderOverlay.show();
      },
    );
    final metaData = ref.watch(uiMetaDataProvider);
    final countryData = ref.watch(countryProvider);
    final membershipData = ref.watch(membershipContainerProvider);
    List<MembershipTier> membershipList = membershipData.value ?? [];
    List<CountryData> countryList = countryData.value ?? [];
    final user = Get.find<CustomerDTO>();
    ref.listen(
      updateAccountProvider,
      (_, next) {
        next.maybeWhen(
          orElse: () => {},
          success: (data) {
            context.loaderOverlay.hide();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              headerAnimationLoop: false,
              body: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: const MulishText(
                  text: 'Profile Updated Succesfully.',
                  fontSize: 25.0,
                  textAlign: TextAlign.center,
                ),
              ),
            ).show();
          },
          error: (error) {
            context.loaderOverlay.hide();
            Dialogs.showErrorMessage(context, error);
          },
          loading: () {
            context.loaderOverlay.show();
          },
        );
      },
    );

    return Scaffold(
      appBar:
          CustomAppBar(title: SplashScreenNotifier.getLanguageLabel('Account')),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundRectanglePicture(user: user),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: MulishText(
                              text: 'Not implemented yet',
                              fontSize: 20.0,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit_square),
                      color: CustomColors.hardOrange,
                    ),
                    MulishText(
                        text:
                            SplashScreenNotifier.getLanguageLabel('Edit Photo'))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Dialogs.selectLanguageDialog(context, ref);
                      },
                      icon: const Icon(Icons.language),
                      color: CustomColors.hardOrange,
                    ),
                    MulishText(
                        text: SplashScreenNotifier.getLanguageLabel(
                            'Select language'))
                  ],
                ),

                // const SizedBox(
                //   height: 10.0,
                // ),
                metaData.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, __) => const Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                  data: (metadata) {
                    return Column(
                      children: metadata.map((field) {
                        if (!field.isReadOnly) {
                          if (field.customerFieldValueList is List && field.fieldType == "LIST") {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  SplashScreenNotifier.getLanguageLabel(
                                      field.fieldLabel),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                DropdownButtonFormField<String>(
                                  value: returnValue(field.fieldName, field.customeAttributeId).toString() == ""
                                      ? field.customerFieldValueList.isNotEmpty ? field.customerFieldValueList.first['FieldName'] : "" // Assuming field.customerFieldValueList is a List<CustomerFieldValue>
                                      : returnValue(field.fieldName, field.customeAttributeId).toString(),
                                  items: List<Map<String, dynamic>>.from(
                                          field.customerFieldValueList)
                                      .map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value[
                                          'Key'], // Assigning CustomerFieldValue to value
                                      child: Text(
                                          SplashScreenNotifier.getLanguageLabel(
                                              value['Value'])),
                                    );
                                  }).toList(),
                                  onChanged: (title) =>
                                      request[field.fieldName] = {
                                    "value": title,
                                    "customAttributeId":
                                        field.customeAttributeId,
                                    "customerFieldType": field.fieldType
                                  },
                                ),
                              ],
                            );
                          }
                          if (field.fieldName == "BIRTH_DATE" ||
                              field.fieldType == "DATE") {
                            return CustomDatePicker(
                              initialText: returnValue(field.fieldName,
                                          field.customeAttributeId) ==
                                      null
                                  ? SplashScreenNotifier.getLanguageLabel(
                                      'Date of birth')
                                  : returnValue(field.fieldName,
                                          field.customeAttributeId)
                                      .toString()
                                      .split("T")[0],
                              initialDateTime: returnValue(field.fieldName,
                                          field.customeAttributeId) ==
                                      null
                                  ? DateTime.now()
                                  : DateTime.parse(returnValue(field.fieldName,
                                          field.customeAttributeId)
                                      .toString()),
                              margin:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              labelText: SplashScreenNotifier.getLanguageLabel(
                                  'Date of birth'),
                              format: 'MM-dd-yyyy',
                              onItemSelected: (dob) =>
                                  request[field.fieldName] = {
                                "value": DateFormat('MM-dd-yyyy')
                                    .format(dob)
                                    .toString(),
                                "customAttributeId": field.customeAttributeId,
                                "customerFieldType": field.fieldType
                              },
                              suffixIcon: const Icon(
                                Icons.date_range_outlined,
                                color: CustomColors.hardOrange,
                              ),
                            );
                          }
                          if (field.fieldName == "CONTACT_PHONE") {
                            return CustomVerifyTextField(
                              onSaved: (value) => request[field.fieldName] = {
                                "value": value.toString(),
                                "customAttributeId": field.customeAttributeId,
                                "customerFieldType": field.fieldType
                              },
                              label:
                                  '${SplashScreenNotifier.getLanguageLabel(field.fieldLabel)}${field.validationType == "M" ? "*" : ""}',
                              initialValue: returnValue(
                                      field.fieldName, field.customeAttributeId)
                                  .toString(),
                              margins:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              contactType: ContactType.phone,
                              phoneOrEmail: returnValue(
                                      field.fieldName, field.customeAttributeId)
                                  .toString(),
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              required: field.validationType == "M",
                              key: const Key("Phone"),
                              verificationStatusInitialValue: true,
                            );
                          }
                          if (field.fieldName == "EMAIL") {
                            return CustomVerifyTextField(
                              onSaved: (value) => request[field.fieldName] = {
                                "value": value.toString(),
                                "customAttributeId": field.customeAttributeId,
                                "customerFieldType": field.fieldType
                              },
                              label:
                                  '${SplashScreenNotifier.getLanguageLabel(field.fieldLabel)}${field.validationType == "M" ? "*" : ""}',
                              initialValue: returnValue(
                                      field.fieldName, field.customeAttributeId)
                                  .toString(),
                              margins:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              contactType: ContactType.email,
                              phoneOrEmail: returnValue(
                                      field.fieldName, field.customeAttributeId)
                                  .toString(),
                              required: field.validationType == "M",
                              key: const Key("Email"),
                              verificationStatusInitialValue: true,
                            );
                          }
                          if (field.fieldName == "MEMBERSHIP_ID") {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  SplashScreenNotifier.getLanguageLabel(
                                      field.fieldLabel),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                DropdownButtonFormField<String>(
                                  // value: returnValue(field.fieldName, field.customeAttributeId).toString() == ""
                                  //     ? field.customerFieldValueList.first.value // Assuming field.customerFieldValueList is a List<CustomerFieldValue>
                                  //     : returnValue(field.fieldName, field.customeAttributeId).toString(),
                                  items:
                                      List<MembershipTier>.from(membershipList)
                                          .map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value.membershipName,
                                      child: Text(
                                          SplashScreenNotifier.getLanguageLabel(
                                              value.membershipName)),
                                    );
                                  }).toList(),
                                  onChanged: (title) =>
                                      request[field.fieldName] = {
                                    "value": title,
                                    "customAttributeId":
                                        field.customeAttributeId,
                                    "customerFieldType": field.fieldType
                                  },
                                ),
                              ],
                            );
                          }
                          if (field.fieldName == "COUNTRY_CODE" ||
                              field.fieldName == "COUNTRY_NAME") {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  SplashScreenNotifier.getLanguageLabel(
                                      field.fieldLabel),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                DropdownButtonFormField<String>(
                                  // value: returnValue(field.fieldName, field.customeAttributeId).toString() == ""
                                  //     ? field.customerFieldValueList.first.value // Assuming field.customerFieldValueList is a List<CustomerFieldValue>
                                  //     : returnValue(field.fieldName, field.customeAttributeId).toString(),
                                  items: List<CountryData>.from(countryList)
                                      .map((value) {
                                    return DropdownMenuItem<String>(
                                      value: field.fieldName == "COUNTRY_CODE"
                                          ? value.countryCode
                                          : value.countryId.toString(),
                                      child: Text(
                                          SplashScreenNotifier.getLanguageLabel(
                                              field.fieldName == "COUNTRY_CODE"
                                                  ? value.countryCode
                                                  : value.countryName)),
                                    );
                                  }).toList(),
                                  onChanged: (title) =>
                                      request[field.fieldName] = {
                                    "value": title,
                                    "customAttributeId":
                                        field.customeAttributeId,
                                    "customerFieldType": field.fieldType
                                  },
                                ),
                              ],
                            );
                          }
                          return CustomTextField(
                            initialValue: returnValue(
                                    field.fieldName, field.customeAttributeId)
                                .toString(),
                            onSaved: (value) => request[field.fieldName] = {
                              "value": value.toString(),
                              "customAttributeId": field.customeAttributeId,
                              "customerFieldType": field.fieldType
                            },
                            label:
                                '${SplashScreenNotifier.getLanguageLabel(field.fieldLabel)}${field.validationType == "M" ? "*" : ""}',
                            margins: const EdgeInsets.symmetric(vertical: 10.0),
                            required: field.validationType == "M",
                            formatters: field.fieldType == "NUMBER"
                                ? [FilteringTextInputFormatter.digitsOnly]
                                : null,
                          );
                        } else {
                          return SizedBox();
                        }
                      }).toList(),
                    );
                  },
                ),
                // CustomTextField(
                //   onSaved: (firstName) => user.profilefirtName = firstName,
                //   label: SplashScreenNotifier.getLanguageLabel('First Name'),
                //   initialValue: user.firstName,
                //   margins: const EdgeInsets.symmetric(vertical: 10.0),
                // ),
                // CustomTextField(
                //   onSaved: (lastName) => user.profilelastName = lastName,
                //   label: SplashScreenNotifier.getLanguageLabel('Last Name'),
                //   initialValue: user.lastName,
                //   margins: const EdgeInsets.symmetric(vertical: 10.0),
                // ),
                // CustomVerifyTextField(
                //   onSaved: (email) => newEmail = email,
                //   label: SplashScreenNotifier.getLanguageLabel('Email Address'),
                //   initialValue: user.email,
                //   margins: const EdgeInsets.symmetric(vertical: 10.0),
                //   contactType: ContactType.email,
                //   phoneOrEmail: user.email ?? '',
                // ),
                // CustomVerifyTextField(
                //   onSaved: (phone) => newPhone = phone,
                //   label: SplashScreenNotifier.getLanguageLabel('Phone'),
                //   initialValue: user.phone,
                //   margins: const EdgeInsets.symmetric(vertical: 10.0),
                //   contactType: ContactType.phone,
                //   phoneOrEmail: user.phone ?? '',
                // ),
                // CustomDatePicker(
                //   margin: const EdgeInsets.symmetric(vertical: 10.0),
                //   labelText: SplashScreenNotifier.getLanguageLabel('Date of birth'),
                //   format: 'MM-dd-yyyy',
                //   initialText: user.dateOfBirth?.cleanDate(),
                //   onItemSelected: (dob) => user.profiledateOfBirth = DateFormat('MM-dd-yyyy').format(dob),
                //   suffixIcon: const Icon(
                //     Icons.date_range_outlined,
                //     color: CustomColors.hardOrange,
                //   ),
                // ),
                CustomButton(
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      ref
                          .read(updateAccountProvider.notifier)
                          .updateProfile(user, request);
                    }
                  },
                  label: SplashScreenNotifier.getLanguageLabel('SAVE'),
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                ),
                CustomButton(
                  onTap: () => {
                    ref.read(loginProvider.notifier).resendDeleteOtp(
                        user.phone == null || user.phone == ""
                            ? user.email!
                            : user.phone!),
                    Navigator.pushNamed(context, Routes.kDeleteOTP)
                  },
                  label:
                      SplashScreenNotifier.getLanguageLabel('DELETE PROFILE'),
                )
              ],
            ),
          ),
        ),
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
  final EdgeInsets padding;
  final EdgeInsets margins;
  final bool required;

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

dynamic returnValue(String key, int customId) {
  final user = Get.find<CustomerDTO>();
  switch (key) {
    case "FIRST_NAME":
      return user.profileDto?.firstName;
    case "CUSTOMER_NAME":
      return user.profileDto?.firstName;
    case "MIDDLE_NAME":
      return user.profileDto?.middleName;
    case "LAST_NAME":
      return user.profileDto?.lastName;
    case "BIRTH_DATE":
      return user.profileDto?.dateOfBirth;
    case "GENDER":
      return user.profileDto?.gender;
    case "ANNIVERSARY":
      return user.profileDto?.anniversary;
    case "NOTES":
      return user.profileDto?.notes;
    case "DESIGNATION":
      return user.profileDto?.designation;
    case "UNIQUE_ID":
      return user.profileDto?.uniqueIdentifier;
    case "USERNAME":
      return user.profileDto?.userName;
    case "RIGHTHANDED":
      return user.profileDto?.rightHanded;
    case "PASSWORD":
      return user.profileDto?.password;
    case "TAXCODE":
      return user.profileDto?.taxCode;
    case "COMPANY":
      return user.profileDto?.company;

    case "TITLE":
      return user.profileDto?.title;
    case "TERMS_AND_CONDITIONS":
      return user.profileDto?.policyTermsAccepted;
    //
    case "EMAIL":
      return user.email;
    //   phoneContactDTO.add(PhoneContactDTO(
    //     contactTypeId: ContactType.email.typeId,
    //     contactType: ContactType.email.type,
    //     attribute1: value["value"],
    //     isActive: true,
    //   ));
    //   email = value["value"];
    //
    case "CONTACT_PHONE":
      return user.phone;
    //   phoneContactDTO.add(PhoneContactDTO(
    //     contactTypeId: ContactType.phone.typeId,
    //     contactType: ContactType.phone.type,
    //     attribute1: value["value"],
    //     isActive: true,
    //   ));
    //   phone = value["value"];
    //
    case "WECHAT_ACCESS_TOKEN":
      try {
        var contactDtoList = user.contactDtoList
            ?.where((element) => element.contactType == ContactType.wechat.type)
            .first;
        return contactDtoList?.attribute1 ?? "";
      } catch (e) {
        return "";
      }

    default:
      CustomDataDTO? customDataDtoList;
      dynamic returnValue;
      try {
        customDataDtoList = user.customDataSetDto?.customDataDtoList
            ?.where((element) => element.customAttributeId == customId)
            .first;
        if (customDataDtoList?.customDataText != null) {
          returnValue = customDataDtoList?.customDataText;
        } else if (customDataDtoList?.customDataDate != null) {
          returnValue = customDataDtoList?.customDataDate;
        } else if (customDataDtoList?.customDataNumber != null) {
          returnValue = customDataDtoList?.customDataNumber;
        }
        return returnValue;
      } catch (e) {
        return "";
      }

    // //not included in case will be stored in custom data
    //   CustomDataDTO customDataDTO = CustomDataDTO(
    //     customAttributeId: value["customAttributeId"],
    //     customDataText: value["customerFieldType"] == "NUMBER" || value["customerFieldType"] == "DATE" ? null : value["value"],
    //     customDataNumber: value["customerFieldType"] == "NUMBER" ? int.parse(value["value"]) : null,
    //     customDataDate: value["fieldType"] == "DATE" ? DateTime.parse(value["value"]) : null
    //   );
    //   customDataDtoList.add(customDataDTO);
  }
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
            onSaved: (newValue) => widget.onSaved(newValue ?? ""),
            validator: (value) => (value?.isEmpty ?? false) && widget.required
                ? SplashScreenNotifier.getLanguageLabel('Required')
                : null,
            cursorColor: Colors.black,
            keyboardType: TextInputType.emailAddress,
            obscureText: !_passwordVisible, //This will obscure text dynamically
            decoration: InputDecoration(
              hintText:
                  SplashScreenNotifier.getLanguageLabel('Enter your password'),
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
