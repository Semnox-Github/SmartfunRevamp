import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/enums/contact_enum.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_app_bar.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/custom_date_picker.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/account/provider/update_account/update_account_provider.dart';
import 'package:semnox/features/home/widgets/more_view_widgets/round_rectangle_picture.dart';
import 'package:semnox/features/login/pages/login_page.dart';
import 'package:semnox/features/sign_up/pages/sign_up_page.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/phone_contact_dto.dart';

import 'widget/custom_verify_textfiel.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountPage();
}

class _AccountPage extends ConsumerState<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> request = {};
  String? userPassword;

  @override
  Widget build(BuildContext context) {
    final isPasswordDisabled = ref.watch(isPasswordDisabledProvider);
    final metaData = ref.watch(uiMetaDataProvider);
    final user = Get.find<CustomerDTO>();
    String newEmail = '';
    String newPhone = '';
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
      appBar: CustomAppBar(title: SplashScreenNotifier.getLanguageLabel('Account')),
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
                    MulishText(text: SplashScreenNotifier.getLanguageLabel('Edit Photo'))
                  ],
                ),


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
                        if (field.customerFieldName == "EMAIL" || field.customerFieldName == "CONTACT_PHONE") {
                          return CustomVerifyTextField(
                            onSaved: (value) => request[field.customerFieldName] = value,
                            label: '${SplashScreenNotifier.getLanguageLabel(field.entityFieldCaption)}${field.validationType == "M" ? "*" : ""}',
                            initialValue: user.phone,
                            margins: const EdgeInsets.symmetric(vertical: 10.0),
                            contactType: ContactType.phone,
                            phoneOrEmail: user.phone ?? '',
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



                CustomTextField(
                  onSaved: (firstName) => user.profilefirtName = firstName,
                  label: SplashScreenNotifier.getLanguageLabel('First Name'),
                  initialValue: user.firstName,
                  margins: const EdgeInsets.symmetric(vertical: 10.0),
                ),
                CustomTextField(
                  onSaved: (lastName) => user.profilelastName = lastName,
                  label: SplashScreenNotifier.getLanguageLabel('Last Name'),
                  initialValue: user.lastName,
                  margins: const EdgeInsets.symmetric(vertical: 10.0),
                ),
                CustomVerifyTextField(
                  onSaved: (email) => newEmail = email,
                  label: SplashScreenNotifier.getLanguageLabel('Email Address'),
                  initialValue: user.email,
                  margins: const EdgeInsets.symmetric(vertical: 10.0),
                  contactType: ContactType.email,
                  phoneOrEmail: user.email ?? '',
                ),
                CustomVerifyTextField(
                  onSaved: (phone) => newPhone = phone,
                  label: SplashScreenNotifier.getLanguageLabel('Phone'),
                  initialValue: user.phone,
                  margins: const EdgeInsets.symmetric(vertical: 10.0),
                  contactType: ContactType.phone,
                  phoneOrEmail: user.phone ?? '',
                ),
                CustomDatePicker(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  labelText: SplashScreenNotifier.getLanguageLabel('Date of birth'),
                  format: 'MM-dd-yyyy',
                  initialText: user.dateOfBirth.cleanDate(),
                  onItemSelected: (dob) => user.profiledateOfBirth = DateFormat('MM-dd-yyyy').format(dob),
                  suffixIcon: const Icon(
                    Icons.date_range_outlined,
                    color: CustomColors.hardOrange,
                  ),
                ),
                CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      user.contactDtoList?.clear();
                      user.profilecontactDtoList = [
                        PhoneContactDTO(
                          contactTypeId: ContactType.email.typeId,
                          contactType: ContactType.email.type,
                          attribute1: newEmail,
                          isActive: true,
                        ),
                        PhoneContactDTO(
                          contactTypeId: ContactType.phone.typeId,
                          contactType: ContactType.phone.type,
                          attribute1: newPhone,
                          isActive: true,
                        ),
                      ];
                      user.profileaddressDtoList = [];
                      ref.read(updateAccountProvider.notifier).updateProfile(user);
                    }
                  },
                  label: SplashScreenNotifier.getLanguageLabel('SAVE'),
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                ),
                CustomButton(
                  onTap: () => Navigator.pushNamed(context, Routes.kDeleteOTP),
                  label: SplashScreenNotifier.getLanguageLabel('DELETE PROFILE'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
