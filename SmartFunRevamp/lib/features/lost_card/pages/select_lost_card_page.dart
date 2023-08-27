import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/view/home_view.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';
import 'package:semnox/features/lost_card/pages/lost_card_page.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_bottom_sheet_button.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class SelectCardLostPage extends ConsumerStatefulWidget {
  const SelectCardLostPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectCardLostPageState();
}

class _SelectCardLostPageState extends ConsumerState<SelectCardLostPage> {
  late CardDetails selectedCard;
  late List<CardDetails> cards;
  late CardDetails? cardDetails;
  @override
  void initState() {
    cardDetails = ref.read(currentCardProvider);
    if (cardDetails != null) {
      //is added to cards list as the only card
      List<CardDetails> selectedCard = [];
      selectedCard.add(cardDetails!);
      cards = selectedCard;
    } else {
      //if no card was selected, i.e. when landed from Search, get all the user cards
      cards = List<CardDetails>.from(ref.read(CardsProviders.userCardsProvider).value ?? []);
      cards.removeWhere((element) => element.isBlocked() || element.isExpired());
    }
    selectedCard = cards.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          SplashScreenNotifier.getLanguageLabel('Lost Card'),
          style: const TextStyle(
            color: CustomColors.customBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: CarouselCards(
                cards: cards,
                onCardChanged: (index) {
                  selectedCard = cards[index];
                },
                showLinkCard: false,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20.0),
                    MulishText(
                      text: SplashScreenNotifier.getLanguageLabel('Lost Card Terms'),
                      fontColor: CustomColors.hardOrange,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10.0),
                    MulishText(
                      text: SplashScreenNotifier.getLanguageLabel(
                          'This Card cannot be used for any further transactions. A temporary will be issued, exachange the temporary card for a new physical carrd at site'),
                      textAlign: TextAlign.center,
                      fontColor: CustomColors.customBlack,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 20.0),
                    const Divider(
                      color: CustomColors.customLigthBlack,
                      thickness: 0.5,
                    ),
                    const SizedBox(height: 20.0),
                    MulishText(
                      text: SplashScreenNotifier.getLanguageLabel('40 need to paid while exchanging for a new physical card'),
                      textAlign: TextAlign.center,
                      fontColor: CustomColors.customBlack,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 20.0),
                    const Divider(
                      color: CustomColors.customLigthBlack,
                      thickness: 0.5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BottomSheetButton(
        label: SplashScreenNotifier.getLanguageLabel('BLOCK & ISSUE REPLACEMENT'),
        onTap: () {
          Logger().d(selectedCard.accountNumber);
          ref.listenManual(
            CardsProviders.lostCardProvider(selectedCard),
            (previous, next) {
              next.maybeWhen(
                orElse: () => {},
                loading: () => context.loaderOverlay.show(),
                data: (data) {
                  context.loaderOverlay.hide();
                  ref.invalidate(CardsProviders.userCardsProvider);
                  ref.read(CardsProviders.userCardsProvider);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LostCardPage(cardDetails: selectedCard),
                    ),
                  );
                },
                error: (e, s) {
                  context.loaderOverlay.hide();
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.scale,
                    title: SplashScreenNotifier.getLanguageLabel('Lost Card'),
                    desc: SplashScreenNotifier.getLanguageLabel('Sorry, we have had a problem. Please contact our Staff'),
                    btnOkOnPress: () {},
                  ).show();
                },
              );
            },
            fireImmediately: true,
          );
        },
      ),
    );
  }
}
