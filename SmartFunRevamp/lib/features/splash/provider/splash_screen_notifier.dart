import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/authenticate_base_url_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_base_url_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_lookups_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_parafait_languages_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_string_for_localization_use_case.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/di/injection_container.dart';

import 'package:semnox/core/domain/entities/language/language_container_dto.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';

part 'splash_screen_state.dart';
part 'splash_screen_notifier.freezed.dart';

final splashScreenProvider = StateNotifierProvider<SplashScreenNotifier, SplashScreenState>(
  (ref) => SplashScreenNotifier(Get.find<GetBaseURLUseCase>(), Get.find<AuthenticateBaseURLUseCase>()),
);
final systemUserProvider = StateProvider<SystemUser?>((ref) {
  return null;
});

final homePageCMSProvider = Provider<String?>((ref) {
  return null;
});

Map<dynamic, dynamic> languageLabels = {};
String helpUrl = "";
String privacyPolicyUrl = "";
String termsUrl = "";

class SplashScreenNotifier extends StateNotifier<SplashScreenState> {
  final GetBaseURLUseCase _getBaseURL;
  final AuthenticateBaseURLUseCase _authenticateBaseURLUseCase;

  SplashScreenNotifier(this._getBaseURL, this._authenticateBaseURLUseCase) : super(const _Initial());

  static String getUrl(String site) {
    String responseUrl = "";
    switch (site) {
      case "Help":
        responseUrl = helpUrl;
        break;
      case "Privacy":
        responseUrl = privacyPolicyUrl;
        break;
      case "Terms":
        responseUrl = termsUrl;
        break;
    }
    return responseUrl;
  }

  void getBaseUrl() async {
    final response = await _getBaseURL();
    response.fold(
      (l) => Logger().e(l.message),
      (r) async {
        Get.put<String>(r.gateWayURL, tag: 'baseURL');
        authenticateBaseURL(r.gateWayURL);
      },
    );
  }

  void authenticateBaseURL(String baseUrl) async {
    final response = await _authenticateBaseURLUseCase();
    response.fold(
      (l) => state = _Error(l.message),
      (r) {
        authenticateApi(r, baseUrl);
        state = const _Success();
      },
    );
  }

  static String getLanguageLabel(String labelKey) {
    String? languageLabel = languageLabels[labelKey];
    if (languageLabel.isNullOrEmpty()) {
      debugPrint('Label not found for key: "$labelKey"');
      return labelKey;
    } else {
      return languageLabel.toString();
    }
  }

  static final parafaitLanguagesProvider = FutureProvider<LanguageContainerDTO>((ref) async {
    final GetParafaitLanguagesUseCase getParafaitLanguagesUseCase = Get.find<GetParafaitLanguagesUseCase>();
    //Request language list always to master site
    final response = await getParafaitLanguagesUseCase(siteId: "1010");
    Logger().d(response);
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });

  static final getStringForLocalization = FutureProvider.autoDispose.family<void, String>((ref, languageId) async {
    final GetStringForLocalizationUseCase getStringForLocalizationUseCase = Get.find<GetStringForLocalizationUseCase>();
    //Request language strings always with master site
    final response = await getStringForLocalizationUseCase(siteId: "1010", languageId: languageId);
    // get the language Json from the assets
    String defaultLanguageStrings = await rootBundle.loadString("assets/localization/strings.json");
    final jsonDefaultLanguageStrings = jsonDecode(defaultLanguageStrings);

    //get the language json from the api
    // ignore: prefer_typing_uninitialized_variables
    late final jsonLanguageAPIResult;
    response.forEach((r) {
      jsonLanguageAPIResult = r;
    });

    //Combining both language json objects
    final combinedMap = {};
    combinedMap
      ..addAll(jsonDefaultLanguageStrings)
      ..addAll(jsonLanguageAPIResult);
    languageLabels = combinedMap;
    Logger().d(combinedMap);
  });

  static final getInitialData = FutureProvider.autoDispose<void>((ref) async {
    final GetLookupsUseCase getLookupsUseCase = Get.find<GetLookupsUseCase>();
    final response = await getLookupsUseCase(siteId: (ref.read(loginProvider.notifier).selectedSite?.siteId ?? 1010).toString());
    const infoLookupName = "SELFSERVICEAPP_CUSTOMLINKS";
    response.forEach((r) {
      for (var element in r.lookupsContainerDTOList) {
        if (element.lookupName == infoLookupName) {
          for (var lookup in element.lookupValuesContainerDTOList) {
            switch (lookup.lookupValue) {
              case "Help":
                helpUrl = lookup.description.toString();
                break;
              case "Privacy Policy":
                privacyPolicyUrl = lookup.description.toString();
                break;
              case "Terms of Use":
                termsUrl = lookup.description.toString();
                break;
            }
          }
        }
      }
    });
    Logger().d(response);
  });
}
