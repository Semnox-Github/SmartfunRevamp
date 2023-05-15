import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/widgets/input_text_field.dart';
import 'package:semnox/features/home/provider/link_card/link_card_provider.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class UpdateNicknameCard extends ConsumerWidget {
  UpdateNicknameCard({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String mCardNumber = '';
    ref.listen(
      linkCardProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () => {},
          success: () async {
            context.loaderOverlay.hide();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.scale,
              title: SplashScreenNotifier.getLanguageLabel('Link A Card'),
              desc: SplashScreenNotifier.getLanguageLabel(
                  'Card linked successfully.'),
              btnOkOnPress: () {},
            ).show();
          },
          error: (e) {
            context.loaderOverlay.hide();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.scale,
              title: SplashScreenNotifier.getLanguageLabel('Link A Card'),
              desc: e,
              btnOkOnPress: () {},
            ).show();
          },
          inProgress: () => context.loaderOverlay.show(),
        );
      },
    );
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.purple.shade500,
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: 170,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      SplashScreenNotifier.getLanguageLabel(
                          'Edit nickanme of your card'),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InputTextField(
                    initialValue: '',
                    onSaved: (_) {},
                    // onSaved: (cardNumber) => mCardNumber = cardNumber,
                    hintText: SplashScreenNotifier.getLanguageLabel(
                        'Choose nickname'),
                    prefixIcon: IconButton(
                      icon: const Icon(
                        Icons.add_card,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12.0),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: CustomGradients.linearGradient,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      gradient: CustomGradients.linearGradient,
                    ),
                    margin: const EdgeInsets.all(3),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Logger().d('Linking');
                          _formKey.currentState!.save();
                          // ref
                          //     .read(linkCardProvider.notifier)
                          //     .linkCard(mCardNumber);
                        }
                      },
                      child: Text(
                        SplashScreenNotifier.getLanguageLabel('SAVE'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
