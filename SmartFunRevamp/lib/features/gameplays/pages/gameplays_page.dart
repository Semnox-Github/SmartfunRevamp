import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/gameplays/account_gameplays.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/gameplays/provider/gameplays_provider.dart';
import 'package:semnox/features/gameplays/widgets/dialog_item.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/view/home_view.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

import '../../../core/widgets/custom_app_bar.dart';

class GameplaysPage extends ConsumerStatefulWidget {
  const GameplaysPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameplaysPageState();
}

class _GameplaysPageState extends ConsumerState<GameplaysPage> {
  late CardDetails selectedCard;
  late List<CardDetails> cards;
  late CardDetails? cardDetails;
  late int _cardIndex;
  @override
  void initState() {
    super.initState();
    _cardIndex = 0;
    cards = List<CardDetails>.from(
        ref.read(CardsProviders.userCardsProvider).value ?? []);
    cardDetails = ref.read(currentCardProvider);
    // cards.removeWhere((element) => element.isBlocked() || element.isExpired());
    if (cardDetails != null) {
      cards.forEachIndexed((index, element) {
        if (element.accountNumber == cardDetails!.accountNumber) {
          _cardIndex = index;
        }
      });
    }
    selectedCard = cards[_cardIndex];
  }

  @override
  Widget build(BuildContext context) {
    final cmsBody = ref.watch(cmsBodyStyleProvider);

    try {
      return Scaffold(
        backgroundColor: HexColor.fromHex(cmsBody?.appBackGroundColor),
        appBar: CustomAppBar(
          title: SplashScreenNotifier.getLanguageLabel("Game Plays"),
        ),
        // AppBar(
        //     title: Text(
        //       SplashScreenNotifier.getLanguageLabel('Game Plays'),
        //       style: const TextStyle(
        //         color: CustomColors.customBlue,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselCards(
                initialPosition: _cardIndex,
                cards: cards,
                showLinkCard: false,
                onCardChanged: (index) {
                  setState(() {
                    selectedCard = cards[index];
                  });
                },
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    return ref
                        .watch(GameplaysProvider.accountGameplaysProvider(
                            selectedCard.accountId ?? 0))
                        .maybeWhen(
                          orElse: () => Container(),
                          loading: () => const Center(
                              child: CircularProgressIndicator.adaptive()),
                          error: (error, stackTrace) => const Center(
                            child: MulishText(
                              text: 'No Gameplays Found',
                              fontSize: 25.0,
                            ),
                          ),
                          data: (data) {
                            if (data.isEmpty) {
                              return Center(
                                child: MulishText(
                                  text: SplashScreenNotifier.getLanguageLabel(
                                      'This card has no gameplays'),
                                  fontSize: 30.0,
                                ),
                              );
                            }
                            return ListView.builder(
                              itemCount: data.length,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return Card(
                                  color: HexColor.fromHex(
                                      cmsBody?.appBackGroundColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MulishText(
                                            text: '${item.game}',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        MulishText(
                                          text:
                                              DateFormat('MMM d, yyyy, h:mm a')
                                                  .format(DateTime.parse(
                                                      item.playDate ?? "")),
                                          fontSize: 14,
                                          fontColor: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            MulishText(
                                              text: item.site ?? 'N/A',
                                              fontColor: Colors.black,
                                            ),
                                            MulishText(
                                              text: 'Ref: ${item.gameplayId}',
                                              fontColor: Colors.black,
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                        )
                                      ],
                                    ),
                                    onTap: () => showBalanceDialog(item),
                                  ),
                                );
                              },
                            );
                          },
                        );
                  },
                ),
              )
            ],
          ),
        ),
      );
    } catch (e) {
      Logger().e(e);
      return Container();
    }
  }

  void showBalanceDialog(AccountGameplays item) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.noHeader,
        dialogBackgroundColor: Theme.of(context).dialogBackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MulishText(
              text: '${item.game}',
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            MulishText(
              text: SplashScreenNotifier.getLanguageLabel(
                  "Balance consumed during gameplay"),
              fontSize: 12,
              fontColor: Colors.grey,
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: GridView(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 16 / 9,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                children: [
                  DialogItem(
                    title: SplashScreenNotifier.getLanguageLabel("Credits"),
                    value: item.totalCredits.toStringAsFixed(0),
                  ),
                  DialogItem(
                    title: SplashScreenNotifier.getLanguageLabel("Bonus"),
                    value: item.totalBonus.toStringAsFixed(0),
                  ),
                  DialogItem(
                    title: SplashScreenNotifier.getLanguageLabel("Time"),
                    value: item.time.toStringAsFixed(0),
                  ),
                  DialogItem(
                    title: SplashScreenNotifier.getLanguageLabel("Card Game"),
                    value: item.cardGame
                        .toStringAsFixed(0), //item.courtesy.toStringAsFixed(0),
                  ),
                ],
              ),
            ),
          ],
        ),
        btnOk: CustomButton(
          onTap: () => Navigator.pop(context, 'OK'),
          label: SplashScreenNotifier.getLanguageLabel("Done"),
        )).show();
  }
}
