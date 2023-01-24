import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/modules/languages/model/language_container_dto.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/widgets/buttons/semnox_circle_loader.dart';
import 'package:semnox_core/widgets/semnox_widget/login_widget/view_model/login_user_form_view_model.dart';

// ignore: must_be_immutable
class LoginForm extends StatefulWidget {
  Function(UserData)? userdata;
  LoginUserViewModel? viewModel;
  LoginForm(
    this.userdata, {
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, WidgetRef ref, child) {
      final viewModel = ref.watch(LoginUserViewModel.provider);
      return Form(
        key: viewModel.formKey,
        child: Column(
          children: [
            SemnoxTextFormField(
              properties: viewModel.userNameField,
              prefix: const Icon(Icons.person_outline),
              position: LabelPosition.inside,
            ),
            SizedBox(
              height: 20.mapToIdealHeight(context),
            ),
            SemnoxTextFormField(
              properties: viewModel.passwordField,
              position: LabelPosition.inside,
              prefix: SemnoxIcons.key.toIcon(),
            ),
            SizedBox(
              height: 15.mapToIdealHeight(context),
            ),
            const SemnoxText.bodyMed1(text: "-- or --"),
            SizedBox(
              height: 15.mapToIdealHeight(context),
            ),
            SemnoxTextFormField(
              properties: viewModel.cardNoField,
              position: LabelPosition.inside,
            ),
            if (viewModel.siteField.items.length > 1) ...{
              SizedBox(
                height: 15.mapToIdealHeight(context),
              ),
              const SemnoxText.bodyMed1(text: "--  --"),
              SizedBox(
                height: 15.mapToIdealHeight(context),
              ),
              SemnoxDropdownField<SiteViewDTO>(
                properties: viewModel.siteField,
                enabled: viewModel
                    .siteField.enabled, //viewModel.siteField.items.length>1,
                position: LabelPosition.top,
                prefix: SemnoxIcons.creditCard.toIcon(),
              ),
            },
            SizedBox(
              height: 20.mapToIdealHeight(context),
            ),
            SemnoxDropdownField<LanguageContainerDto>(
              properties: viewModel.languageField,
              enabled: viewModel
                  .languageField.enabled, //viewModel.siteField.items.length>1,
              position: LabelPosition.inside,
              prefix: SemnoxIcons.creditCard.toIcon(),
            ),
            SizedBox(
              height: 20.mapToIdealHeight(context),
            ),
            Row(
              children: [
                DataProviderBuilder<bool>(
                    enableAnimation: false,
                    dataProvider: viewModel.buttonStates,
                    loader: (context) {
                      return Expanded(
                        child: SemnoxFlatButton(
                          child: const SemnoxCircleLoader(),
                          onPressed: () {},
                        ),
                      );
                    },
                    builder: (context, snapshot) {
                      return Expanded(
                        child: SemnoxFlatButton(
                          child: const SemnoxText.button(
                            text:"LOGIN",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            try {
                              if (!(viewModel.formKey.currentState
                                      ?.validate() ??
                                  false)) return;
                              // viewModel.buttonState.startLoading();

                              widget.userdata!(UserData(
                                  viewModel.userNameField.value,
                                  viewModel.passwordField.value,
                                  "",
                                  viewModel.siteField.value,
                                  viewModel.languageField.value));
                            } catch (e) {
                              SemnoxSnackbar.error(context, "$e");
                            }
                          },
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
      );
    });
  }
}
