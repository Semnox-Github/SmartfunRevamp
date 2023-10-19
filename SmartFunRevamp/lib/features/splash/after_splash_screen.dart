import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/language/language_container_dto.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/image_handler.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

final currentLanguageProvider = StateProvider<LanguageContainerDTOList?>((ref) {
  final languageContainerDTO = ref.watch(languangeContainerProvider);
  if (languageContainerDTO == null || languageContainerDTO.languageContainerDTOList.isEmpty) {
    return null;
  }
  return languageContainerDTO.languageContainerDTOList
          .firstWhereOrNull((element) => element.languageCode == Platform.localeName.replaceAll('_', '-')) ??
      languageContainerDTO.languageContainerDTOList.firstWhereOrNull((element) => element.languageCode == 'en-US');
});

class AfterSplashScreen extends ConsumerWidget {
  const AfterSplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currenLang = ref.watch(currentLanguageProvider);
    ref.watch(getStringForLocalization).maybeWhen(
      orElse: () {
        context.loaderOverlay.hide();
      },
      loading: () {
        context.loaderOverlay.show();
      },
    );
    ref.watch(SplashScreenNotifier.getInitialData);
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
              child: const ImageHandler(
                imageKey: "language_pick_image_path",
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
                      final langs = ref.watch(languangeContainerProvider);
                      return DropdownButtonFormField<LanguageContainerDTOList>(
                        isExpanded: true,
                        value: currenLang,
                        hint: const MulishText(text: 'Select a language'),
                        items: langs?.languageContainerDTOList.map((item) {
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
                        onTap: () {
                          Navigator.pushReplacementNamed(context, Routes.kLogInPage);
                        },
                        label: SplashScreenNotifier.getLanguageLabel("LOGIN"),
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
                        onPressed: () => Navigator.pushNamed(context, Routes.kSignUpPage),
                        label: SplashScreenNotifier.getLanguageLabel('SIGN UP'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
