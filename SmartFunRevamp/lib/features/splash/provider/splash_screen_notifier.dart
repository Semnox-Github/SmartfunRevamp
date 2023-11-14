import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/core/domain/use_cases/splash_screen/get_lookups_use_case.dart';
import 'package:semnox/core/utils/extensions.dart';

import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_screen_state.dart';
part 'splash_screen_notifier.freezed.dart';

final splashScreenProvider =
    StateNotifierProvider<SplashScreenNotifier, SplashScreenState>(
  (ref) => SplashScreenNotifier(),
);

final systemUserProvider = StateProvider<SystemUser?>((ref) {
  return null;
});

Map<dynamic, dynamic> languageLabes = {};
String helpUrl = "";
String privacyPolicyUrl = "";
String termsUrl = "";
String successRedirectURL = "";
String failureRedirectURL = "";
String cancelRedirectURL = "";
int? masterSiteId;

class SplashScreenNotifier extends StateNotifier<SplashScreenState> {
  late String? splashScreenImgURL = '';
  SplashScreenNotifier() : super(const _InProgress());

  static String getLookupValue(String site) {
    String response = "";
    switch (site) {
      case "Help":
        response = helpUrl;
        break;
      case "Privacy":
        response = privacyPolicyUrl;
        break;
      case "Terms":
        response = termsUrl;
        break;
      case "SUCCESS_REDIRECT_URL":
        print("success redirect url $successRedirectURL");
        response = successRedirectURL.split("?")[0];
        break;
      case "FAILURE_REDIRECT_URL":
        print("failure redirect url $failureRedirectURL");
        response = failureRedirectURL.split("?")[0];
        break;
      case "CANCEL_REDIRECT_URL":
        print("CANCEL_REDIRECT_URL $failureRedirectURL");
        response = cancelRedirectURL.split("?")[0];
        break;
    }
    return response;
  }

  static String getLanguageLabel(String labelKey) {
    String? languageLabel = languageLabes[labelKey];

    if (languageLabel.isNullOrEmpty()) {
      logNonExistentLanguageLabel(labelKey);
      return labelKey;
    } else {
      return languageLabel.toString();
    }
  }

  static logNonExistentLanguageLabel(String label) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final labels = prefs.getStringList('labels');
    if (labels == null) {
      await prefs.setStringList('labels', [label]);
    } else {
      if (!labels.contains(label)) {
        labels.add(label);
        await prefs.setStringList('labels', labels);
      }
    }
    // Logger().d(labels);
  }

  static Future<List<String>> getNonExistentLanguageLabel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final labels = prefs.getStringList('labels');
    return labels ?? [];
  }

  static final getInitialData = FutureProvider.autoDispose<void>((ref) async {
    final GetLookupsUseCase getLookupsUseCase = Get.find<GetLookupsUseCase>();
    final masterSiteId = ref.watch(masterSiteProvider)?.siteId ?? 1010;
    final response = await getLookupsUseCase(
      siteId:
          (ref.read(loginProvider.notifier).selectedSite?.siteId.toString() ??
              masterSiteId.toString()),
    );
    const infoLookupName = "SELFSERVICEAPP_CUSTOMLINKS";
    const webSiteConfig = "WEB_SITE_CONFIGURATION";
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
        //Payment callback URLs
        if (element.lookupName == webSiteConfig) {
          for (var lookup in element.lookupValuesContainerDTOList) {
            switch (lookup.lookupValue) {
              case "SUCCESS_REDIRECT_URL":
                successRedirectURL = lookup.description.toString();
                break;
              case "FAILURE_REDIRECT_URL":
                failureRedirectURL = lookup.description.toString();
                break;
              case "CANCEL_REDIRECT_URL":
                cancelRedirectURL = lookup.description.toString();
                break;
            }
          }
        }
      }
    });
    Logger().d(response);
  });
}
