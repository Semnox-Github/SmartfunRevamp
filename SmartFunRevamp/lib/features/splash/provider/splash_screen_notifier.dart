import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/authenticate_base_url_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_base_url_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_home_page_cms_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_lookups_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_parafait_languages_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_string_for_localization_use_case.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/di/injection_container.dart';

import 'package:semnox/core/domain/entities/language/language_container_dto.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';

part 'splash_screen_state.dart';
part 'splash_screen_notifier.freezed.dart';

final splashScreenProvider = StateNotifierProvider<SplashScreenNotifier, SplashScreenState>(
  (ref) => SplashScreenNotifier(
    Get.find<GetBaseURLUseCase>(),
    Get.find<AuthenticateBaseURLUseCase>(),
    Get.find<LocalDataSource>(),
  ),
);
final systemUserProvider = StateProvider<SystemUser?>((ref) {
  return null;
});

final homePageCMSProvider = Provider<HomePageCMSResponse?>((ref) {
  return null;
});
final getStringForLocalization = FutureProvider<Map<dynamic, dynamic>>((ref) async {
  final currentLang = ref.watch(currentLanguageProvider);
  if (currentLang == null) {
    return {};
  }
  final GetStringForLocalizationUseCase getStringForLocalizationUseCase = Get.find<GetStringForLocalizationUseCase>();
  final langId = currentLang.languageId.toString();
  //Request language strings always with master site
  final response = await getStringForLocalizationUseCase(siteId: SplashScreenNotifier.getMasterSite().toString(), languageId: langId);
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
  languageLabes = combinedMap;
  return combinedMap;
});
Map<dynamic, dynamic> languageLabes = {};
String helpUrl = "";
String privacyPolicyUrl = "";
String termsUrl = "";
int? masterSiteId;

class SplashScreenNotifier extends StateNotifier<SplashScreenState> {
  final GetBaseURLUseCase _getBaseURL;
  final AuthenticateBaseURLUseCase _authenticateBaseURLUseCase;
  final LocalDataSource _localDataSource;
  late String? splashScreenImgURL = '';
  SplashScreenNotifier(this._getBaseURL, this._authenticateBaseURLUseCase, this._localDataSource) : super(const _InProgress());

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
    splashScreenImgURL = await _localDataSource.retrieveValue<String>(LocalDataSource.kSplashScreenURL);
    Logger().d(splashScreenImgURL);
    if (!splashScreenImgURL.isNullOrEmpty()) {
      state = _RetrievedSplashImageURL(splashScreenImgURL);
    }
    final response = await _getBaseURL();
    response.fold(
      (l) => Logger().e(l.message),
      (r) async {
        Get.put<String>(r.gateWayURL, tag: 'baseURL');
        authenticateBaseURL(r.gateWayURL);
      },
    );
  }

  static void setMasterSite(int? siteId) async {
    masterSiteId = siteId;
  }

  static int getMasterSite() {
    return masterSiteId!;

  }

  void authenticateBaseURL(String baseUrl) async {
    final response = await _authenticateBaseURLUseCase();
    response.fold(
      (l) => state = _Error(l.message),
      (r) async {
        authenticateApi(r, baseUrl);
        if (splashScreenImgURL.isNullOrEmpty()) {
          getHomePageCMS();
        } else {
          await Future.delayed(const Duration(seconds: 3));
          state = const _Success();
        }
      },
    );
  }

  void getHomePageCMS() async {
    final useCase = Get.find<GetHomePageCMSUseCase>();
    final response = await useCase();
    response.fold(
      (l) => state = _Error(l.message),
      (r) async {
        _localDataSource.saveValue(LocalDataSource.kSplashScreenURL, r.cmsImages.splashScreenPath);
        splashScreenImgURL = r.cmsImages.splashScreenPath;
        await Future.delayed(const Duration(seconds: 3));
        state = const _Success();
      },
    );
  }

  static String getLanguageLabel(String labelKey) {
    String? languageLabel = languageLabes[labelKey];
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
    final response = await getParafaitLanguagesUseCase(siteId: SplashScreenNotifier.getMasterSite().toString());
    Logger().d(response);
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });

  static final getInitialData = FutureProvider.autoDispose<void>((ref) async {
    final GetLookupsUseCase getLookupsUseCase = Get.find<GetLookupsUseCase>();
    final response = await getLookupsUseCase(siteId: (ref.read(loginProvider.notifier).selectedSite?.siteId ?? SplashScreenNotifier.getMasterSite()).toString());
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
