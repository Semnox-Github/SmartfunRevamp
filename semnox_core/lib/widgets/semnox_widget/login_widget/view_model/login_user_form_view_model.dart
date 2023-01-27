import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/streams.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/languages/bl/language_view_bl.dart';
import 'package:semnox_core/modules/languages/model/language_container_dto.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/modules/sites/bl/site_view_bl.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

class UserData {
  String? loginId;
  String? password;
  String? cardNumber;
  SiteViewDTO? site;
  LanguageContainerDto? languageDto;
  UserData(this.loginId, this.password, this.cardNumber, this.site,
      this.languageDto);
}

class LoginUserViewModel extends ChangeNotifier {
  static final provider = ChangeNotifierProvider<LoginUserViewModel>((ref) {
    return LoginUserViewModel();
  });

  LoginUserViewModel() {
    if (!kReleaseMode) {
      userNameField.setInitialValue("semnox");
      passwordField.setInitialValue("semnoX!1");
      init();
    }
  }

  final formKey = GlobalKey<FormState>();
  ExecutionContextDTO? executionContext;
  List<SiteViewDTO>? sitelist;
  List<LanguageContainerDto>? languageDto;
  final DataProvider<bool> buttonState = DataProvider<bool>(initial: false);
  ValueStream<DataState<bool>> get buttonStates => buttonState.dataStream;
  late SemnoxTextFieldProperties userNameField = SemnoxTextFieldProperties(
    label: "UserName",
  );
  late SemnoxTextFieldProperties cardNoField =
      SemnoxTextFieldProperties(label: "Card Number");
  late SemnoxTextFieldProperties passwordField =
      SemnoxTextFieldProperties(label: "Password", isObscured: true);
  SemnoxDropdownProperties<SiteViewDTO> siteField =
      SemnoxDropdownProperties<SiteViewDTO>(items: []);
  SemnoxDropdownProperties<LanguageContainerDto> languageField =
      SemnoxDropdownProperties<LanguageContainerDto>(items: []);

  TranslationProvider? _translationProvider;

  void init() async {
    executionContext = await ExecutionContextProvider().getExecutionContext();
    sitelist = await SitesViewListBL(executionContext).getSites();
    languageDto = await LanguageViewListBL(executionContext).getLanguages();
    var list = sitelist;
    siteField = SemnoxDropdownProperties<SiteViewDTO>(
        label: "Site",
        items: list!
            .map((e) => DropdownMenuItem<SiteViewDTO>(
                value: e, child: SemnoxText(text: "${e.siteName}")))
            .toList(),
        enabled: true,
        validators: [
          (data) {
            if (data == null) {
              return "Select Any Site";
            }
            return null;
          }
        ]);
    if (list.isNotEmpty) {
      final initial = list.firstWhereOrNull(
          (element) => executionContext?.siteId == element.siteId);
      siteField.setInitialValue(initial ?? list.first);
    }

    var languageList = languageDto;
    languageField = SemnoxDropdownProperties<LanguageContainerDto>(
        label: "Language",
        items: languageList!
            .map((e) => DropdownMenuItem<LanguageContainerDto>(
                value: e, child: SemnoxText(text: "${e.languageName}")))
            .toList(),
        validators: [
          (data) {
            if (data == null) {
              return "Select Any Language";
            }
            return null;
          }
        ]);
    if (languageList.isNotEmpty) {
      final initial = languageList.firstWhereOrNull(
          (element) => executionContext?.languageId == element.languageId);
      languageField.setInitialValue(initial ?? languageList.first);
    }
    notifyListeners();
  }

  getTranslationString(String key) async{
    return await _translationProvider?.getTranslationBykey(key);
  }
}
