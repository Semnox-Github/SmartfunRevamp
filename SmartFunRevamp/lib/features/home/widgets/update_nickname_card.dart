import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/widgets/input_text_field.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/provider/update_card_nickname/update_card_nickname_provider.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class UpdateNicknameCard extends ConsumerWidget {
  final CardDetails cardDetails;
  UpdateNicknameCard({super.key, required this.cardDetails});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String cardNickname = '';
    ref.listen(
      updateCardNicknameProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () => {},
          success: () async {
            context.loaderOverlay.hide();
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(SplashScreenNotifier.getLanguageLabel('Nickname successfully updated')),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 200,
                  right: 20,
                  left: 20,
                ),
              ),
            );
            // TODO: here we should call to something that updates the interface, we could load all cards again from API or just update the visible nickcname on card
            ref.invalidate(CardsProviders.userCardsProvider);
            ref.read(CardsProviders.userCardsProvider);
          },
          error: (e) {
            context.loaderOverlay.hide();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.scale,
              title: SplashScreenNotifier.getLanguageLabel('Update Nickname'),
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
      height: 180,
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
                      SplashScreenNotifier.getLanguageLabel('Edit nickanme of your card'),
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
                    onSaved: (newNickname) => cardNickname = newNickname,
                    hintText: SplashScreenNotifier.getLanguageLabel('Choose nickname'),
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
                          Logger().d('updating nickname');
                          _formKey.currentState!.save();
                          ref.read(updateCardNicknameProvider.notifier).updateCardNickname(cardDetails.accountId!, cardNickname);
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
