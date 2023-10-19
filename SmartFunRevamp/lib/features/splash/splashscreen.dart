import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_execution_context_use_case.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/di/injection_container.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

SiteViewDTO? userSelectedSite;
Future<void> registerLoggedUser(CustomerDTO customerDTO) async {
  final localDataSource = Get.find<LocalDataSource>();
  final response = await localDataSource.retrieveCustomClass(LocalDataSource.kSelectedSite);
  final getExecutionContextUseCase = Get.find<GetExecutionContextUseCase>();
  final selectedSite = response.fold(
    (l) => null,
    (r) {
      return SiteViewDTO.fromJson(r);
    },
  );
  userSelectedSite = selectedSite;
  registerUser(customerDTO);
  final executionContextResponse = await getExecutionContextUseCase(selectedSite!.siteId!);
  executionContextResponse.fold(
    (l) {},
    (r) {
      Get.replace<SmartFunApi>(SmartFunApi('', r));
    },
  );
}

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
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
      placeholder: (_, __) => const Center(child: CircularProgressIndicator.adaptive()),
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

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    // final customer = ref.watch(customDTOProvider).valueOrNull;
    void nextPage() => Navigator.pushReplacementNamed(context, Routes.kAfterSplashScreenPage);
    ref.listen<NewSplashScreenState>(
      newSplashScreenProvider,
      (_, next) {
        next.maybeWhen(
          orElse: () {},
          error: (message) {
            AwesomeDialog(
              context: context,
              headerAnimationLoop: false,
              desc: message,
              dialogType: DialogType.error,
              btnOkOnPress: () {},
            ).show();
          },
          success: (cms, langDto, masterSite, parafaitDefaults, needsSiteSelection, user, notificationData) {
            ref.read(newHomePageCMSProvider.notifier).update((_) => cms);
            ref.read(languangeContainerProvider.notifier).update((_) => langDto);
            ref.read(masterSiteProvider.notifier).update((_) => masterSite);
            ref.read(parafaitDefaultsProvider.notifier).update((_) => parafaitDefaults);
            ref.read(userProvider.notifier).update((_) => user);
            if (user == null) {
              nextPage();
            } else {
              if (needsSiteSelection) {
                Navigator.pushReplacementNamed(context, Routes.kEnableLocation);
              } else {
                registerLoggedUser(user).then((value) {
                  if (userSelectedSite != null) {
                    ref.read(loginProvider.notifier).setSite(userSelectedSite!);
                    if (notificationData != null) {
                      ref.listenManual(
                        CardsProviders.userCardsProvider,
                        (previous, next) {
                          next.when(
                            data: (data) {
                              Navigator.pushReplacementNamed(context, Routes.kHomePage);
                              Navigator.pushNamed(context, notificationData.path);
                              Logger().d(data);
                            },
                            error: (error, stackTrace) => Logger().e("message", error, stackTrace),
                            loading: () => Logger().d("Loading"),
                          );
                        },
                        fireImmediately: true,
                      );
                    } else {
                      Navigator.pushReplacementNamed(context, Routes.kHomePage);
                    }
                  } else {
                    Navigator.pushReplacementNamed(context, Routes.kEnableLocation);
                  }
                });
              }
            }

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
      body: ref.watch(newSplashScreenProvider).maybeWhen(
            orElse: () => Container(),
            error: (message) => const Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
                size: 50.0,
              ),
            ),
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
              final imageUrl = ref.read(newSplashScreenProvider.notifier).splashImageUrl;
              return SplashScreenImage(imageUrl);
            },
          ),
    );
  }

  @override
  void initState() {
    ref.read(newSplashScreenProvider.notifier).getSplashImage();
    super.initState();
  }
}
