import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/entities/language/language_container_dto.dart';
import 'package:semnox/core/domain/use_cases/config/get_parfait_defaults_use_case.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/cms_provider.dart';

import 'provider/splash_screen_notifier.dart';

final parafaitDefaultsProvider = FutureProvider<ParafaitDefaultsResponse>((ref) async {
  final getDefaults = Get.find<GetParafaitDefaultsUseCase>();
  final response = await getDefaults();
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});
final currentLanguageProvider = StateProvider<LanguageContainerDTOList?>((ref) {
  final languageList = ref.watch(SplashScreenNotifier.parafaitLanguagesProvider).valueOrNull;
  if (languageList == null) {
    return null;
  }
  return languageList.languageContainerDTOList.firstWhereOrNull((element) => element.languageCode == Platform.localeName) ??
      languageList.languageContainerDTOList.firstWhere((element) => element.languageCode == 'en-US');
});

class AfterSplashScreen extends ConsumerWidget {
  const AfterSplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(parafaitDefaultsProvider);
    ref.watch(SplashScreenNotifier.getInitialData);
    final currenLang = ref.watch(currentLanguageProvider);
    ref.watch(getStringForLocalization).maybeWhen(
      orElse: () {
        context.loaderOverlay.hide();
      },
      loading: () {
        context.loaderOverlay.show();
      },
    );
    final imagePath = ref.watch(cmsProvider).value?.cmsImages.languagePickImagePath;
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
              child: imagePath == null
                  ? const SizedBox.shrink()
                  : CachedNetworkImage(
                      imageUrl: imagePath,
                      placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) {
                        return const Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 50.0,
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 10.0),
            Text(
              SplashScreenNotifier.getLanguageLabel('QUICK CARD RECHARGES'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: CustomColors.customBlack,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10.0),
            MulishText(
              text: SplashScreenNotifier.getLanguageLabel('QUICK CARD RECHARGES DETAIL'),
              fontSize: 16.0,
              fontColor: CustomColors.customBlack,
              fontWeight: FontWeight.w500,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MulishText(
                    text: SplashScreenNotifier.getLanguageLabel('Preferred Language to be used in the app'),
                    textAlign: TextAlign.start,
                    fontColor: CustomColors.customBlack,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return ref.watch(SplashScreenNotifier.parafaitLanguagesProvider).maybeWhen(
                            orElse: () => Container(),
                            error: (e, s) => MulishText(
                              text: 'An error has ocurred $e',
                            ),
                            loading: () => const Center(child: CircularProgressIndicator()),
                            data: (data) {
                              return DropdownButton<LanguageContainerDTOList>(
                                isExpanded: true,
                                value: currenLang,
                                hint: const MulishText(text: 'Select a language'),
                                items: data.languageContainerDTOList.map((item) {
                                  return DropdownMenuItem<LanguageContainerDTOList>(
                                    value: item,
                                    child: Text(item.languageName),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  ref.read(currentLanguageProvider.notifier).state = value;
                                },
                              );
                            },
                          );
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MulishText(
                        text: SplashScreenNotifier.getLanguageLabel("Have an account?"),
                      ),
                      CustomButton(
                        onTap: () {},
                        label: SplashScreenNotifier.getLanguageLabel("Have an account?"),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MulishText(
                        text: SplashScreenNotifier.getLanguageLabel('New to SmartFun?'),
                      ),
                      CustomCancelButton(
                        onPressed: () {},
                        label: SplashScreenNotifier.getLanguageLabel('SIGN UP'),
                      )
                    ],
                  ),
                )
              ],
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           MulishText(
            //             text: SplashScreenNotifier.getLanguageLabel("Have an account?"),
            //             fontColor: CustomColors.customBlack,
            //             fontSize: 16.0,
            //             fontWeight: FontWeight.bold,
            //           ),
            //           Container(
            //             width: double.infinity,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(12.0),
            //               gradient: currenLang == null ? CustomGradients.disabledGradient : CustomGradients.linearGradient,
            //             ),
            //             margin: const EdgeInsets.all(3),
            //             child: TextButton(
            //               onPressed: currenLang == null ? null : () => Navigator.pushReplacementNamed(context, Routes.kLogInPage),
            //               child: Text(
            //                 SplashScreenNotifier.getLanguageLabel('LOGIN'),
            //                 style: const TextStyle(
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     const SizedBox(width: 5.0),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           MulishText(
            //             text: SplashScreenNotifier.getLanguageLabel('New to SmartFun?'),
            //             textAlign: TextAlign.center,
            //             fontColor: CustomColors.customBlack,
            //             fontSize: 16.0,
            //             fontWeight: FontWeight.bold,
            //           ),
            //           Container(
            //             width: double.infinity,
            //             decoration: BoxDecoration(
            //               gradient: currenLang == null ? CustomGradients.disabledGradient : CustomGradients.linearGradient,
            //               borderRadius: BorderRadius.circular(15.0),
            //             ),
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(12.0),
            //                 color: currenLang == null ? Colors.grey : Colors.white,
            //               ),
            //               margin: const EdgeInsets.all(3),
            //               child: TextButton(
            //                 onPressed: () => Navigator.pushNamed(context, Routes.kSignUpPage),
            //                 child: Text(
            //                   SplashScreenNotifier.getLanguageLabel('SIGN UP'),
            //                   style: const TextStyle(
            //                     color: CustomColors.hardOrange,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
