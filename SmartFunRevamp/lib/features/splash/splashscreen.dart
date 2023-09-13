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
          success: (cms, langDto, masterSite, parafaitDefaults,
              needsSiteSelection, notificationData) {
            ref.read(newHomePageCMSProvider.notifier).update((_) => cms);
            ref
                .read(languangeContainerProvider.notifier)
                .update((_) => langDto);
            ref.read(masterSiteProvider.notifier).update((_) => masterSite);
            ref
                .read(parafaitDefaultsProvider.notifier)
                .update((_) => parafaitDefaults);
            if (customer == null) {
              nextPage();
            } else {
              if (needsSiteSelection) {
                Navigator.pushReplacementNamed(context, Routes.kEnableLocation);
              } else {
                registerLoggedUser(customer).then((value) {
                  if (notificationData != null) {
                    ref.listenManual(
                      CardsProviders.userCardsProvider,
                      (previous, next) {
                        next.when(
                          data: (data) {
                            Navigator.pushReplacementNamed(
                                context, Routes.kHomePage);
                            Navigator.pushNamed(context, notificationData.path);
                            Logger().d(data);
                          },
                          error: (error, stackTrace) =>
                              Logger().e("message", error, stackTrace),
                          loading: () => Logger().d("Loading"),
                        );
                      },
                      fireImmediately: true,
                    );
                  } else {
                    Navigator.pushNamed(context, Routes.kHomePage);
                  }
                });
              }
            }
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
            success: (_, __, ___, ____, _____, ______) {
              final imageUrl =
                  ref.read(newSplashScreenProvider.notifier).splashImageUrl;
              return SplashScreenImage(imageUrl);
            },
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
