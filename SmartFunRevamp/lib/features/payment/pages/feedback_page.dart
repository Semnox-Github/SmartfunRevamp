import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/payment/provider/feedback_provider.dart';
import 'package:semnox/features/payment/widgets/feedback_value_item.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

import '../../../core/routes.dart';
import '../../../core/widgets/custom_app_bar.dart';

class FeedbackPage extends ConsumerWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surveyProvider = ref.watch(surveyDetailsProvider);
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.kHomePage, // replace with your home route
            (Route<dynamic> route) => false,
          );
          return false; // prevent the default back button behavior
        },
        child: Scaffold(
          appBar:CustomAppBar(title: SplashScreenNotifier.getLanguageLabel('Feedback')),
          //  AppBar(
          //   leading: const SizedBox.shrink(),
          //   centerTitle: true,
          //   title: const MulishText(text: 'Feedback'),
          // ),
          body: SafeArea(
            minimum: const EdgeInsets.all(20.0),
            child: surveyProvider.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              error: (_, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    MulishText(
                      text: SplashScreenNotifier.getLanguageLabel(
                          'There was an error'),
                    )
                  ],
                );
              },
              data: (surveyDetailsResponse) {
                return SingleChildScrollView(
                  child: Column(
                    children: List.of([
                      ...surveyDetailsResponse.surveyDetails.map(
                        (surveyDetail) {
                          return FeedbackValueOption(
                              surveyDetail: surveyDetail);
                        },
                      ).toList(),
                      CustomButton(
                        onTap: () {
                          ref.listenManual(
                            postFeedback,
                            (previous, next) {
                              next.when(
                                error: (error, stacktrace) {
                                  Logger().e("Error", error, stacktrace);
                                  context.loaderOverlay.hide();
                                  Dialogs.showErrorMessage(
                                    context,
                                    'Error Sending The Feedback',
                                    onOkPress: () => {
                                      Navigator.popUntil(
                                          context, (route) => route.isFirst),
                                    },
                                  );
                                },
                                loading: () => context.loaderOverlay.show(),
                                data: (_) {
                                  context.loaderOverlay.hide();
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    headerAnimationLoop: false,
                                    animType: AnimType.scale,
                                    title: 'Feedback',
                                    desc: 'Thank you for your feedback',
                                    descTextStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                    btnOkOnPress: () {
                                      Navigator.popUntil(
                                          context, (route) => route.isFirst);
                                    },
                                    btnOkText:
                                        SplashScreenNotifier.getLanguageLabel(
                                            'OK'),
                                    btnOkColor: Colors.blue,
                                  ).show();
                                },
                              );
                            },
                            fireImmediately: true,
                          );
                        },
                        label: SplashScreenNotifier.getLanguageLabel(
                            'Send Feedback'),
                        margin: const EdgeInsets.only(top: 10.0),
                      )
                    ]),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
