import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_execution_context_use_case.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/di/injection_container.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

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
  registerUser(customerDTO);
  final executionContextResponse =
      await getExecutionContextUseCase(selectedSite!.siteId!);
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

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    ref.read(newSplashScreenProvider.notifier).getSplashImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(customDTOProvider).valueOrNull;
    void nextPage() =>
        Navigator.pushReplacementNamed(context, Routes.kAfterSplashScreenPage);
    ref.listen<NewSplashScreenState>(
      newSplashScreenProvider,
      (_, next) {
        next.maybeWhen(
          orElse: () {},
          success:
              (cms, langDto, masterSite, parafaitDefaults, needsSiteSelection) {
            ref.read(newHomePageCMSProvider.notifier).update((_) => cms);
            ref
                .read(languangeContainerProvider.notifier)
                .update((_) => langDto);
            ref.read(masterSiteProvider.notifier).update((_) => masterSite);
            ref
                .read(parafaitDefaultsProvider.notifier)
                .update((_) => parafaitDefaults);
            final parafaitDefault = ref.watch(parafaitDefaultsProvider);
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
                .then((value) async => {
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
                          await Dialogs.downloadUpdateDialog(context, storeUrl),
                          if (customer == null)
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
                                  registerLoggedUser(customer).then((value) =>
                                      Navigator.pushReplacementNamed(
                                          context, Routes.kHomePage)),
                                }
                            }
                        }
                      else
                        {
                          if (customer == null)
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
                                  registerLoggedUser(customer).then((value) =>
                                      Navigator.pushReplacementNamed(
                                          context, Routes.kHomePage)),
                                }
                            }
                        }
                    });
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
            // success: () => SplashScreenImage(imageUrl),
            retrievedSplashImageURL: (url) => SplashScreenImage(url),
          ),
    );
  }
}

class SplashScreenImage extends StatelessWidget {
  const SplashScreenImage(this.url, {super.key});
  final String? url;

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
