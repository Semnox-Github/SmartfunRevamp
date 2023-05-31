import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/use_cases/config/get_parfait_defaults_use_case.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

import '../../core/widgets/mulish_text.dart';

final parafaitDefaultsProvider = FutureProvider<ParafaitDefaultsResponse>((ref) async {
  final getDefaults = Get.find<GetParafaitDefaultsUseCase>();
  final response = await getDefaults();
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});

class AfterSplashScreen extends ConsumerStatefulWidget {
  const AfterSplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AfterSplashScreen> createState() => _AfterSplashScreenState();
}

class _AfterSplashScreenState extends ConsumerState<AfterSplashScreen> {
  String dropdownValue = "";

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(parafaitDefaultsProvider);
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset('assets/splash_screen/after_splash.png'),
            const SizedBox(height: 10.0),
            Text(
              SplashScreenNotifier.getLanguageLabel('QUICK CARD RECHARGES'),
              style: const TextStyle(
                color: CustomColors.customBlack,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(
                color: CustomColors.customBlack,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    SplashScreenNotifier.getLanguageLabel('Preferred Language to be used in the app'),
                    textAlign: TextAlign.start,
                    style: GoogleFonts.mulish(
                      color: CustomColors.customBlack,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      ref.read(SplashScreenNotifier.getInitialData);
                      return ref.watch(SplashScreenNotifier.parafaitLanguagesProvider).maybeWhen(
                            orElse: () => Container(
                              height: 20.0,
                              width: 20.0,
                              color: Colors.red,
                            ),
                            error: (e, s) => MulishText(
                              text: 'An error has ocurred $e',
                            ),
                            loading: () => const CircularProgressIndicator(),
                            data: (data) {
                              dropdownValue = dropdownValue.isEmpty ? data.languageContainerDTOList[0].languageId.toString() : dropdownValue;

                              return DropdownButton<String>(
                                isExpanded: true,
                                value: dropdownValue,
                                items: data.languageContainerDTOList.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.languageId.toString(),
                                    child: Text(item.languageName),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    dropdownValue = value.toString();
                                  });

                                  ref.read(SplashScreenNotifier.getStringForLocalization(value.toString()));
                                  // ref.watch(SplashScreenNotifier.getStringForLocalization(value.toString())).maybeWhen(
                                  //   orElse: () => Container(
                                  //   height: 20.0,
                                  //   width: 20.0,
                                  //   color: Colors.red,
                                  // ),
                                  // error: (e, s) => MulishText(
                                  //   text: 'An error has ocurred $e',
                                  // ),
                                  // loading: () => const CircularProgressIndicator(),
                                  // data: (data) {}
                                  // );
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
                      Text(
                        SplashScreenNotifier.getLanguageLabel("Have an account?"),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(
                          color: CustomColors.customBlack,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          gradient: CustomGradients.linearGradient,
                        ),
                        margin: const EdgeInsets.all(3),
                        child: TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(context, Routes.kLogInPage),
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
                      Text(
                        SplashScreenNotifier.getLanguageLabel('New to SmartFun?'),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(
                          color: CustomColors.customBlack,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
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
                            onPressed: () => Navigator.pushNamed(context, Routes.kSignUpPage),
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
