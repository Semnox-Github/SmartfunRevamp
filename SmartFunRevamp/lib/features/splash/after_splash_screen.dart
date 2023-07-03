// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/use_cases/config/get_parfait_defaults_use_case.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/splashscreen.dart';

import 'provider/splash_screen_notifier.dart';

final parafaitDefaultsProvider = FutureProvider<ParafaitDefaultsResponse>((ref) async {
  final getDefaults = Get.find<GetParafaitDefaultsUseCase>();
  final response = await getDefaults();
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});
final currentLanguageProvider = StateProvider<String?>((ref) => null);

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
            // Image.asset('assets/splash_screen/after_splash.png'),
            CachedNetworkImage(
              imageUrl: imagePath ?? "",
              height: MediaQuery.of(context).size.height * 0.40,
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
            const MulishText(
              text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
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
                              return DropdownButton<String>(
                                isExpanded: true,
                                value: currenLang,
                                hint: const MulishText(text: 'Select a language'),
                                items: data.languageContainerDTOList.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.languageId.toString(),
                                    child: Text(item.languageName),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  ref.read(currentLanguageProvider.notifier).state = value.toString();
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
                        fontColor: CustomColors.customBlack,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          gradient: CustomGradients.linearGradient,
                        ),
                        margin: const EdgeInsets.all(3),
                        child: TextButton(
                          onPressed: () => currenLang.isNullOrEmpty() ? Fluttertoast.showToast(msg: 'Please select a language') : Navigator.pushReplacementNamed(context, Routes.kLogInPage),
                          child: Text(
                            SplashScreenNotifier.getLanguageLabel('LOGIN'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MulishText(
                        text: SplashScreenNotifier.getLanguageLabel('New to SmartFun?'),
                        textAlign: TextAlign.center,
                        fontColor: CustomColors.customBlack,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: CustomGradients.linearGradient,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.all(3),
                          child: TextButton(
                            onPressed: () => currenLang.isNullOrEmpty() ? Fluttertoast.showToast(msg: 'Please select a language') : Navigator.pushNamed(context, Routes.kSignUpPage),
                            child: Text(
                              SplashScreenNotifier.getLanguageLabel('SIGN UP'),
                              style: const TextStyle(
                                color: CustomColors.hardOrange,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
