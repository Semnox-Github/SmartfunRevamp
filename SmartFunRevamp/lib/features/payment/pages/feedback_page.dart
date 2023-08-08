import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/payment/provider/feedback_provider.dart';
import 'package:semnox/features/payment/widgets/feedback_value_item.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class FeedbackPage extends ConsumerWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surveyProvider = ref.watch(surveyDetailsProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        centerTitle: true,
        title: const MulishText(text: 'Feedback'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: surveyProvider.when(
          loading: () => const Center(child: CircularProgressIndicator.adaptive()),
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
                  text: SplashScreenNotifier.getLanguageLabel('There was an error'),
                )
              ],
            );
          },
          data: (surveyDetails) {
            return SingleChildScrollView(
              child: Column(
                children: List.of([
                  ...surveyDetails.map(
                    (surveyDetail) {
                      return FeedbackValueOption(surveyDetail: surveyDetail);
                    },
                  ).toList(),
                  CustomButton(
                    onTap: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    label: SplashScreenNotifier.getLanguageLabel('Send Feedback'),
                    margin: const EdgeInsets.only(top: 10.0),
                  )
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
