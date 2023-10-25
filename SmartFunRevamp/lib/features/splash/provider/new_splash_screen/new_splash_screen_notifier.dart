import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/entities/language/language_container_dto.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/domain/use_cases/config/get_parfait_defaults_use_case.dart';
import 'package:semnox/core/domain/use_cases/select_location/get_master_site_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/authenticate_base_url_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_base_url_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_home_page_cms_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_parafait_languages_use_case.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_string_for_localization_use_case.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/di/injection_container.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:semnox/firebase/firebase_api.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

part 'new_splash_screen_notifier.freezed.dart';
part 'new_splash_screen_state.dart';

final newHomePageCMSProvider = StateProvider<HomePageCMSResponse?>((ref) {
  return null;
});

final languangeContainerProvider = StateProvider<LanguageContainerDTO?>((ref) {
  return null;
});
final masterSiteProvider = StateProvider<SiteViewDTO?>((ref) {
  return null;
});
final parafaitDefaultsProvider = StateProvider<ParafaitDefaultsResponse?>((ref) {
  return null;
});
final userProvider = StateProvider<CustomerDTO?>((ref) {
  return null;
});

final getStringForLocalization = FutureProvider<Map<dynamic, dynamic>>((ref) async {
  final currentLang = ref.watch(currentLanguageProvider);
  if (currentLang == null) {
    return {};
  }
  final masterSiteId = ref.watch(masterSiteProvider)?.siteId;
  final GetStringForLocalizationUseCase getStringForLocalizationUseCase = Get.find<GetStringForLocalizationUseCase>();
  final langId = currentLang.languageId.toString();
  //Request language strings always with master site
  final response = await getStringForLocalizationUseCase(siteId: masterSiteId.toString(), languageId: langId);
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

final newSplashScreenProvider = StateNotifierProvider<NewSplashScreenNotifier, NewSplashScreenState>(
  (ref) => NewSplashScreenNotifier(
    Get.find<GetBaseURLUseCase>(),
    Get.find<AuthenticateBaseURLUseCase>(),
    Get.find<LocalDataSource>(),
  ),
);

class NewSplashScreenNotifier extends StateNotifier<NewSplashScreenState> {
  NewSplashScreenNotifier(this._getBaseURL, this._authenticateBaseURLUseCase, this._localDataSource)
      : super(const _InProgress());
  final GetBaseURLUseCase _getBaseURL;
  final AuthenticateBaseURLUseCase _authenticateBaseURLUseCase;
  final LocalDataSource _localDataSource;

  //<---------------->
  late String? _splashScreenImgURL = '';
  String get splashImageUrl => _splashScreenImgURL ?? '';
  late SiteViewDTO? masterSite;
  late LanguageContainerDTO _languageContainerDTO;
  late ParafaitDefaultsResponse _parafaitDefaultsResponse;
  NotificationsData? _notificationData;
  void getSplashImage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _notificationData = NotificationsData.fromJson(initialMessage.data);
    }
    _splashScreenImgURL = await _localDataSource.retrieveValue<String>(LocalDataSource.kSplashScreenURL);
    if (!_splashScreenImgURL.isNullOrEmpty()) {
      state = _RetrievedSplashImageURL(_splashScreenImgURL);
    }
    _getBaseUrl();
  }

  void _getBaseUrl() async {
    final response = await _getBaseURL();
    response.fold(
      (l) {
        Logger().e(l.message);
        state = _Error(l.message);
      },
      (r) async {
        Get.put<String>(r.gateWayURL, tag: 'baseURL');
        Get.put<String>(r.deprecated, tag: 'appVersionDeprecated');
        _authenticateBaseURL(r.gateWayURL);
      },
    );
  }

  void _authenticateBaseURL(String baseUrl) async {
    final response = await _authenticateBaseURLUseCase();
    response.fold(
      (l) => state = const _Error("We couldn't load the app configuration. Contact an Administrator"),
      (r) async {
        authenticateApi(r, baseUrl);
        _getMasterSite();
      },
    );
  }

  void _getAllParafaitLanguages(int? siteId) async {
    final getParafaitLanguagesUseCase = Get.find<GetParafaitLanguagesUseCase>();
    final response = await getParafaitLanguagesUseCase(siteId: siteId.toString());
    response.fold(
      (l) => state = const _Error("We couldn't load the app configuration. Contact an Administrator"),
      (r) {
        _languageContainerDTO = r;
        _getHomePageCMS();
      },
    );
  }

  void _getHomePageCMS() async {
    final useCase = Get.find<GetHomePageCMSUseCase>();
    final response = await useCase();
    final LocalDataSource glutton = Get.find<LocalDataSource>();
    final customer = await glutton.retrieveCustomer();
    response.fold(
      (l) {
        Logger().e(l.message);
        state = _Error(l.message);
      },
      (r) async {
        if (_splashScreenImgURL != r.cmsImages.splashScreenPath) {
          await _localDataSource.saveValue(LocalDataSource.kSplashScreenURL, r.cmsImages.splashScreenPath);
        }
        final selectedSite = await _localDataSource.retrieveValue(LocalDataSource.kSelectedSite);
        final useLocalCmsJson = dotenv.env['USE_LOCAL_CMS_JSON'] == 'true' ? true : false;
        // Load Local Json
        final String exampleCMSJson = await rootBundle.loadString('assets/json/example_cms.json');
        final data = (await json.decode(exampleCMSJson)) as Map<String, dynamic>;
        final cms = HomePageCMSResponse.fromJson(data['data'][0]);
        state = _Success(
          homePageCMSResponse: useLocalCmsJson ? cms : r,
          languageContainerDTO: _languageContainerDTO,
          siteViewDTO: masterSite!,
          parafaitDefaultsResponse: _parafaitDefaultsResponse,
          needsSiteSelection: selectedSite == null,
          customer: customer,
          notificationsData: _notificationData,
        );
      },
    );
  }

  void _getMasterSite() async {
    final GetMasterSiteUseCase getMasterSiteUseCase = Get.find<GetMasterSiteUseCase>();
    final response = await getMasterSiteUseCase();
    response.fold(
      (l) => state = const _Error('No master site found'),
      (r) {
        masterSite = r.first;
        _getParafaitDefaults(masterSite?.siteId);
      },
    );
  }

  void _getParafaitDefaults(int? siteId) async {
    final GetParafaitDefaultsUseCase getParafaitDefaultsUseCase = Get.find<GetParafaitDefaultsUseCase>();
    final response = await getParafaitDefaultsUseCase(siteId ?? 1010);
    response.fold(
      (l) => state = _Error(l.message),
      (r) async {
        _parafaitDefaultsResponse = r;
        _getAllParafaitLanguages(siteId);
      },
    );
  }
}
