import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/data/datasources/initial/initial_local_data_source.dart';
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

final buttonProvider = StateProvider<ButtonStyle?>((ref) {
  return null;
});

final primaryButtonProvider = StateProvider<PrimaryButtonStyle?>((ref) {
  return null;
});

final cmsPageHeaderProvider = Provider<CMSPageHeader?>((ref) {
  final cms = ref.watch(newHomePageCMSProvider);
  return cms?.cmsPageHeader;
});

final cmsBodyStyleProvider = Provider<CMSPageBodyStyle?>((ref) {
  final cms = ref.watch(newHomePageCMSProvider);
  return cms?.cmsBodyStyle;
});

final secondaryButtonProvider = StateProvider<SecondaryButtonStyle?>((ref) {
  return null;
});

final externalUrlProvider = Provider<ExternalUrls?>((ref) {
  final cms = ref.watch(newHomePageCMSProvider);
  return cms?.externalUrls;
});

final languangeContainerProvider = StateProvider<LanguageContainerDTO?>((ref) {
  return null;
});
final masterSiteProvider = StateProvider<SiteViewDTO?>((ref) {
  return null;
});
final parafaitDefaultsProvider =
    StateProvider<ParafaitDefaultsResponse?>((ref) {
  return null;
});
final userProvider = StateProvider<CustomerDTO?>((ref) {
  return null;
});
final localizationProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {};
});
final getStringForLocalization = FutureProvider((ref) async {
  final currentLang = ref.watch(currentLanguageProvider);
  if (currentLang == null) {
    return;
  }
  final masterSiteId = ref.watch(masterSiteProvider)?.siteId;
  final GetStringForLocalizationUseCase getStringForLocalizationUseCase =
      Get.find<GetStringForLocalizationUseCase>();
  final langId = currentLang.languageId.toString();
  //Request language strings always with master site
  final response = await getStringForLocalizationUseCase(
      siteId: masterSiteId.toString(), languageId: langId);
  response.fold(
    (l) => throw l,
    (r) {
      languageLabes = r;
    },
  );
});
// Provider for CMSPageHeader

final newSplashScreenProvider =
    StateNotifierProvider<NewSplashScreenNotifier, NewSplashScreenState>(
  (ref) => NewSplashScreenNotifier(
    Get.find<GetBaseURLUseCase>(),
    Get.find<AuthenticateBaseURLUseCase>(),
    Get.find<LocalDataSource>(),
  ),
);

class NewSplashScreenNotifier extends StateNotifier<NewSplashScreenState> {
  NewSplashScreenNotifier(
      this._getBaseURL, this._authenticateBaseURLUseCase, this._localDataSource)
      : super(const _InProgress());
  final GetBaseURLUseCase _getBaseURL;
  final AuthenticateBaseURLUseCase _authenticateBaseURLUseCase;
  final LocalDataSource _localDataSource;

  //<---------------->
  late String? _splashScreenImgURL = '';
  String get splashImageUrl => _splashScreenImgURL ?? '';
  late SiteViewDTO? masterSite;
  late ParafaitDefaultsResponse? _parafaitDefaultsResponse;
  NotificationsData? _notificationData;
  void initApp() async {
    final results = await Future.wait([
      _getBaseUrl(),
      getSplashImage(),
    ]);
    _authenticateBaseURL(results.first);
  }

  Future<String> getSplashImage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _notificationData = NotificationsData.fromJson(initialMessage.data);
    }
    _splashScreenImgURL = await _localDataSource
        .retrieveValue<String>(LocalDataSource.kSplashScreenURL);
    if (!_splashScreenImgURL.isNullOrEmpty()) {
      state = _RetrievedSplashImageURL(_splashScreenImgURL);
    }
    return '';
  }

  Future<String> _getBaseUrl() async {
    final response = await _getBaseURL();
    return response.fold(
      (l) => throw l,
      (r) async {
        Get.put<String>(r.gateWayURL, tag: 'baseURL');
        Get.put<String>(r.deprecated, tag: 'appVersionDeprecated');
        return r.gateWayURL;
      },
    );
  }

  void _authenticateBaseURL(String baseUrl) async {
    final response = await _authenticateBaseURLUseCase();
    response.fold(
      (l) => state = const _Error(
          "System User failed to Authenticate. Please close the app and try again. If the error persist please contact support. Error code: 5"),
      (r) async {
        authenticateApi(r, baseUrl);
        _getMasterSite();
      },
    );
  }

  void _getMasterSite() async {
    final GetMasterSiteUseCase getMasterSiteUseCase =
        Get.find<GetMasterSiteUseCase>();
    final response = await getMasterSiteUseCase();
    response.fold(
      (l) => state = const _Error('No master site found'),
      (r) async {
        masterSite = r.first;
        final results = await Future.wait(
          [
            _getParafaitDefaults(masterSite?.siteId ?? 1010),
            _getAllParafaitLanguages(masterSite?.siteId ?? 1010),
          ],
        );

        final parfaitDefaultResponse = results[0] as ParafaitDefaultsResponse;
        final themeNo =
            parfaitDefaultResponse.getDefault("CUSTOMERAPP_THEME_NO") ?? "1";

        final homePageCMSResponse = await _getHomePageCMS(themeNo);

        // final format = _parafaitDefaultsResponse
        //         ?.getDefault(ParafaitDefaultsResponse.currencyFormat) ??
        //     '#,##0.00';

        // print("currency format ****** ${format}");

        // final homepageResponse =
        //     await _getHomePageCMS(_parafaitDefaultsResponse?.getDefault(key));

        final defaultSite =
            await _localDataSource.retrieveValue(LocalDataSource.kDefaultSite);
        final userSelectedSite =
            await _localDataSource.retrieveValue(LocalDataSource.kSelectedSite);
        final selectedSite = defaultSite ?? userSelectedSite;
        final LocalDataSource glutton = Get.find<LocalDataSource>();
        final customer = await glutton.retrieveCustomer();
        state = _Success(
          homePageCMSResponse: homePageCMSResponse
              as HomePageCMSResponse, //results[2] as HomePageCMSResponse,
          languageContainerDTO: results[1] as LanguageContainerDTO,
          siteViewDTO: masterSite!,
          parafaitDefaultsResponse: results[0] as ParafaitDefaultsResponse,
          needsSiteSelection: selectedSite == null,
          customer: customer,
          notificationsData: _notificationData,
        );
      },
    );
  }

  Future<ParafaitDefaultsResponse> _getParafaitDefaults(int? siteId) async {
    final GetParafaitDefaultsUseCase getParafaitDefaultsUseCase =
        Get.find<GetParafaitDefaultsUseCase>();
    final response = await getParafaitDefaultsUseCase(siteId ?? 1010);
    return response.fold(
      (l) => throw l,
      (r) async {
        //reading default site
        var defaultSiteId =
            r.getDefault(ParafaitDefaultsResponse.virtualStoreSiteId);
        //if the default site is set then save it
        if (!defaultSiteId.isNullOrEmpty()) {
          var selectedSite = SiteViewDTO(
              siteId: int.parse(defaultSiteId!),
              openDate: DateTime.now(),
              closureDate: DateTime.now());
          await _localDataSource.saveCustomClass(
              LocalDataSource.kSelectedSite, selectedSite.toJson());
          await _localDataSource.saveCustomClass(
              LocalDataSource.kDefaultSite, selectedSite.toJson());
        } else {
          await _localDataSource
              .retrieveCustomClass(LocalDataSource.kDefaultSite);
        }
        return r;
      },
    );
  }

  Future<LanguageContainerDTO> _getAllParafaitLanguages(int? siteId) async {
    final getParafaitLanguagesUseCase = Get.find<GetParafaitLanguagesUseCase>();
    final response =
        await getParafaitLanguagesUseCase(siteId: siteId.toString());
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  }

  Future<HomePageCMSResponse> _getHomePageCMS(String fileNo) async {
    String fileName = "CMSSmartFun_$fileNo.json";
    print("fileName $fileName");
    final useCase = Get.find<GetHomePageCMSUseCase>();
    final response = await useCase(fileName);
    final LocalDataSource glutton = Get.find<LocalDataSource>();
    final customer = await glutton.retrieveCustomer();
    // final useLocalCmsJson =
    //     dotenv.env['USE_LOCAL_CMS_JSON'] == 'true' ? true : false;

    // Load Local Json
    final String exampleCMSJson =
        await rootBundle.loadString('assets/json/CMSSmartFun_0.json');
    final data = (await json.decode(exampleCMSJson)) as Map<String, dynamic>;
    final cms = HomePageCMSResponse.fromJson(data['data'][0]);
    return response.fold(
      (l) async {
        print("cms has failed $l");
        String fileName = "CMSSmartFun_1.json";
        final useCase = Get.find<GetHomePageCMSUseCase>();
        final response = await useCase(fileName);

        return response.fold((l) async {
          final String exampleCMSJson =
              await rootBundle.loadString('assets/json/CMSSmartFun_0.json');
          final data =
              (await json.decode(exampleCMSJson)) as Map<String, dynamic>;
          final cms = HomePageCMSResponse.fromJson(data['data'][0]);
          return cms;
        }, (r) async {
          if (_splashScreenImgURL != r.cmsImages.splashScreenPath) {
            await _localDataSource.saveValue(
                LocalDataSource.kSplashScreenURL, r.cmsImages.splashScreenPath);
          }

          if (customer != null) {
            languageLabes =
                await Get.find<InitialLocalDatasource>().getSavedJson(
              kStringForLocalizationKey,
              (json) => json,
              'assets/json/strings_for_localization.json',
            );
            Logger().d(languageLabes);
          } else {
            Logger().d('Customer not selected');
          }
          return r;
        });

        //throw l;
      },
      (r) async {
        if (_splashScreenImgURL != r.cmsImages.splashScreenPath) {
          await _localDataSource.saveValue(
              LocalDataSource.kSplashScreenURL, r.cmsImages.splashScreenPath);
        }

        if (customer != null) {
          languageLabes = await Get.find<InitialLocalDatasource>().getSavedJson(
            kStringForLocalizationKey,
            (json) => json,
            'assets/json/strings_for_localization.json',
          );
          Logger().d(languageLabes);
        } else {
          Logger().d('Customer not selected');
        }
        return r;
      },
    );
  }
}
