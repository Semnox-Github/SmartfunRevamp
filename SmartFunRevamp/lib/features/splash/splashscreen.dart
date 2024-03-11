import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/entities/language/language_container_dto.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_execution_context_use_case.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/di/injection_container.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:semnox/themes/main_theme.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

SiteViewDTO? userSelectedSite;
LanguageContainerDTOList? userSelectedLanguage;
Future<void> registerLoggedUser(CustomerDTO customerDTO) async {
  final localDataSource = Get.find<LocalDataSource>();
  final response =
      await localDataSource.retrieveCustomClass(LocalDataSource.kSelectedSite);
  final getExecutionContextUseCase = Get.find<GetExecutionContextUseCase>();
  final selectedSite = response.fold(
    (l) => null,
    (r) {
      return SiteViewDTO.fromJson(r);
    },
  );
  userSelectedSite = selectedSite;
  registerUser(customerDTO);
  if (selectedSite != null) {
    final executionContextResponse =
        await getExecutionContextUseCase(selectedSite.siteId!);
    executionContextResponse.fold(
      (l) {},
      (r) {
        Get.replace<SmartFunApi>(SmartFunApi('', r));
      },
    );
  }
}

Future<void> setSelectedLanguage() async {
  final localDataSource = Get.find<LocalDataSource>();
  final response = await localDataSource
      .retrieveCustomClass(LocalDataSource.kSelectedLanguage);
  final selectedLanguage = response.fold(
    (l) => null,
    (r) {
      return LanguageContainerDTOList.fromJson(r);
    },
  );
  if (selectedLanguage != null) {
    userSelectedLanguage = selectedLanguage;
  }
}

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final cmsBody = ref.watch(cmsBodyStyleProvider);
    void nextPage() =>
        Navigator.pushReplacementNamed(context, Routes.kAfterSplashScreenPage);
    ref.listen<NewSplashScreenState>(
      newSplashScreenProvider,
      (_, next) {
        next.maybeWhen(
          orElse: () {},
          error: (message) {
            AwesomeDialog(
              dialogBackgroundColor:
                  HexColor.fromHex(cmsBody?.popupBackGroundColor),
              context: context,
              headerAnimationLoop: false,
              desc: message,
              dialogType: DialogType.error,
              btnOkOnPress: () {},
              onDismissCallback: (type) {
                SystemNavigator.pop();
              },
            ).show();
          },
          success: (cms, langDto, masterSite, parafaitDefaults,
              needsSiteSelection, user, notificationData) {
            ref.read(newHomePageCMSProvider.notifier).update((_) => cms);
            ref.read(newHomePageCMSProvider.notifier).state = cms;
            final customTheme = setAppTheme(cms.cmsBodyStyle);
            ref.read(appThemeProvider.notifier).state = customTheme;

            ref
                .read(languangeContainerProvider.notifier)
                .update((_) => langDto);
            ref.read(masterSiteProvider.notifier).update((_) => masterSite);
            ref
                .read(parafaitDefaultsProvider.notifier)
                .update((_) => parafaitDefaults);
            ref.read(userProvider.notifier).update((_) => user);
            final parafaitDefault = ref.watch(parafaitDefaultsProvider);
            setSelectedLanguage().then((value) {
              final languageContainerDTO =
                  ref.watch(languangeContainerProvider);

              if (languageContainerDTO == null ||
                  languageContainerDTO.languageContainerDTOList.isEmpty) {
                return null;
              } else {
                if (userSelectedLanguage != null) {
                  final sLang = languageContainerDTO.languageContainerDTOList
                          .firstWhereOrNull((element) =>
                              element.languageCode ==
                              userSelectedLanguage?.languageCode) ??
                      languageContainerDTO.languageContainerDTOList
                          .firstWhereOrNull(
                              (element) => element.languageCode == 'en-US');
                  ref.read(currentLanguageProvider.notifier).state = sLang;
                  return sLang;
                }
              }
            });

            //get the update status "O" => optional | "M" => mandatory | other value => not necesary
            final deprecated = Get.find<String>(tag: 'appVersionDeprecated');
            final isAndroid = Platform.isAndroid;
            final isIOS = Platform.isIOS;
            //get the current date to compare with stored if the update is optional
            final currentDate = DateTime.now().toIso8601String().split("T")[0];
            //get the application download url based on the OS
            final storeUrl = isAndroid
                ? parafaitDefault
                        ?.getDefault(ParafaitDefaultsResponse.playStoreUrl) ??
                    ""
                : isIOS
                    ? parafaitDefault?.getDefault(
                            ParafaitDefaultsResponse.appStoreUrl) ??
                        ""
                    : "";
            //Get the last app update reminder date
            GluttonLocalDataSource()
                .retrieveValue(LocalDataSource.kAppUpdateReminderDate)
                .then(
                  (value) async => {
                    //if application url is not set don't show the update message

                    if (!storeUrl.isNullOrEmpty() &&
                        //if update is mandatory, show everytime the app starts
                        (deprecated == "M" ||
                            //if is optional, show once a day
                            (deprecated == "O" &&
                                currentDate != value.toString())))
                      {
                        GluttonLocalDataSource().saveValue(
                            LocalDataSource.kAppUpdateReminderDate,
                            currentDate),
                        await Dialogs.downloadUpdateDialog(
                            context, storeUrl, ref),
                        if (deprecated != "M")
                          {
                            if (user == null)
                              {
                                nextPage(),
                              }
                            else
                              {
                                if (needsSiteSelection)
                                  {
                                    if (context.mounted)
                                      Navigator.pushReplacementNamed(
                                          context, Routes.kEnableLocation),
                                  }
                                else
                                  {
                                    registerLoggedUser(user).then(
                                      (value) => {
                                        if (userSelectedSite != null)
                                          {
                                            ref
                                                .read(loginProvider.notifier)
                                                .setSite(userSelectedSite!),
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                Routes.kHomePage,
                                                (Route<dynamic> route) =>
                                                    false),
                                          }
                                        else
                                          {
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                Routes.kHomePage,
                                                (Route<dynamic> route) =>
                                                    false),
                                          }
                                      },
                                    ),
                                  }
                              }
                          }
                        else
                          {SystemNavigator.pop()}
                      }
                    else
                      {
                        if (user == null)
                          {
                            nextPage(),
                          }
                        else
                          {
                            if (needsSiteSelection)
                              {
                                Navigator.pushReplacementNamed(
                                    context, Routes.kEnableLocation),
                              }
                            else
                              {
                                registerLoggedUser(user).then(
                                  (value) => {
                                    if (userSelectedSite != null)
                                      {
                                        ref
                                            .read(loginProvider.notifier)
                                            .setSite(userSelectedSite!),
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Routes.kHomePage,
                                            (Route<dynamic> route) => false),
                                      }
                                    else
                                      {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Routes.kHomePage,
                                            (Route<dynamic> route) => false),
                                      }
                                  },
                                ),
                              }
                          }
                      }
                  },
                );

            // final parafaitDefault = ref.watch(parafaitDefaultsProvider);
            // //get the update status "O" => optional | "M" => mandatory | other value => not necesary
            // final deprecated = Get.find<String>(tag: 'appVersionDeprecated');
            // final isAndroid = Platform.isAndroid;
            // final isIOS = Platform.isIOS;
            // //get the current date to compare with stored if the update is optional
            // final currentDate = DateTime.now().toIso8601String().split("T")[0];
            // //get the application download url based on the OS
            // final storeUrl = isAndroid
            //     ? parafaitDefault?.getDefault(ParafaitDefaultsResponse.playStoreUrl) ?? ""
            //     : isIOS
            //         ? parafaitDefault?.getDefault(ParafaitDefaultsResponse.appStoreUrl) ?? ""
            //         : "";
            // //Get the last app update reminder date
            // GluttonLocalDataSource().retrieveValue(LocalDataSource.kAppUpdateReminderDate).then(
            //       (value) async => {
            //         //if application url is not set don't show the update message

            //         if (!storeUrl.isNullOrEmpty() &&
            //             //if update is mandatory, show everytime the app starts
            //             (deprecated == "M" ||
            //                 //if is optional, show once a day
            //                 (deprecated == "O" && currentDate != value.toString())))
            //           {
            //             GluttonLocalDataSource().saveValue(LocalDataSource.kAppUpdateReminderDate, currentDate),
            //             await Dialogs.downloadUpdateDialog(context, storeUrl),
            //             if (deprecated != "M")
            //               {
            //                 if (user == null)
            //                   {
            //                     nextPage(),
            //                   }
            //                 else
            //                   {
            //                     if (needsSiteSelection)
            //                       {
            //                         if (context.mounted)
            //                           Navigator.pushReplacementNamed(context, Routes.kEnableLocation),
            //                       }
            //                     else
            //                       {
            //                         registerLoggedUser(customer).then(
            //                           (value) => {
            //                             if (userSelectedSite != null)
            //                               {
            //                                 ref.read(loginProvider.notifier).setSite(userSelectedSite!),
            //                                 Navigator.pushReplacementNamed(context, Routes.kHomePage),
            //                               }
            //                             else
            //                               {
            //                                 Navigator.pushReplacementNamed(context, Routes.kHomePage),
            //                               }
            //                           },
            //                         ),
            //                       }
            //                   }
            //               }
            //             else
            //               {SystemNavigator.pop()}
            //           }
            //         else
            //           {
            //             if (customer == null)
            //               {
            //                 nextPage(),
            //               }
            //             else
            //               {
            //                 if (needsSiteSelection)
            //                   {
            //                     Navigator.pushReplacementNamed(context, Routes.kEnableLocation),
            //                   }
            //                 else
            //                   {
            //                     registerLoggedUser(customer).then(
            //                       (value) => {
            //                         if (userSelectedSite != null)
            //                           {
            //                             ref.read(loginProvider.notifier).setSite(userSelectedSite!),
            //                             Navigator.pushReplacementNamed(context, Routes.kHomePage)
            //                           }
            //                         else
            //                           {
            //                             Navigator.pushReplacementNamed(context, Routes.kHomePage),
            //                           }
            //                       },
            //                     ),
            //                   }
            //               }
            //           }
            //       },
            //     );
          },
        );
      },
    );
    return Scaffold(
      backgroundColor: HexColor.fromHex(cmsBody?.appBackGroundColor),
      body: ref.watch(newSplashScreenProvider).maybeWhen(
        orElse: () {
          context.loaderOverlay.hide();
          return Container();
        },
        error: (message) {
          context.loaderOverlay.hide();
          return const Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
              size: 50.0,
            ),
          );
        },
        inProgress: () {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/splash_screen/splash_screen.png"),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        retrievedSplashImageURL: (url) {
          return SplashScreenImage(url);
        },
        success: (_, __, ___, ____, _____, ______, _______) {
          final imageUrl =
              ref.read(newSplashScreenProvider.notifier).splashImageUrl;
          return SplashScreenImage(imageUrl);
        },
      ),
    );
  }

  Future<bool> isNetworkConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> checkNetworkConnectivity() async {
    bool isConnected = await isNetworkConnected();
    final cmsBody = ref.watch(cmsBodyStyleProvider);
    final backgroundColor = HexColor.fromHex(cmsBody?.popupBackGroundColor);

    if (isConnected) {
      // Network is available, proceed with your splash screen logic
      ref.read(newSplashScreenProvider.notifier).initApp();
    } else {
      // Network is not available, show an error message or handle accordingly
      showNetworkErrorDialog(backgroundColor);
    }
  }

  @override
  void initState() {
    ref.read(newSplashScreenProvider.notifier).initApp();
    super.initState();
    checkNetworkConnectivity();
  }

  void showNetworkErrorDialog(Color color) {
    AwesomeDialog(
      dialogBackgroundColor: color,
      context: context,
      headerAnimationLoop: false,
      desc: 'No internet connection',
      dialogType: DialogType.error,
      btnOkOnPress: () {
        SystemNavigator.pop();
      },
      descTextStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      btnOkText: SplashScreenNotifier.getLanguageLabel('OK'),
      btnOkColor: Colors.red,
      onDismissCallback: (type) {
        SystemNavigator.pop();
      },
    ).show();
  }
}

class SplashScreenImage extends StatelessWidget {
  final String? url;
  const SplashScreenImage(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    if (url.isNullOrEmpty()) {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splash_screen/splash_screen.png"),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: url!,
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.fill,
      placeholder: (_, __) =>
          const Center(child: CircularProgressIndicator.adaptive()),
      errorWidget: (context, url, error) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/splash_screen/splash_screen.png"),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
