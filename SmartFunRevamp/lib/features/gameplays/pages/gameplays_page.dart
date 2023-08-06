import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/gameplays/provider/gameplays_provider.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class GameplaysPage extends ConsumerStatefulWidget {
  const GameplaysPage({Key? key, this.cardDetails}) : super(key: key);

  final CardDetails? cardDetails;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameplaysPageState();
}

class _GameplaysPageState extends ConsumerState<GameplaysPage> {
  late CardDetails selectedCard;
  late List<CardDetails> cards;
  @override
  void initState() {
    if (widget.cardDetails != null) {
      //is added to cards list as the only card
      List<CardDetails> selectedCard = [];
      selectedCard.add(widget.cardDetails!);
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
    try {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            SplashScreenNotifier.getLanguageLabel('Game Plays'),
            style: const TextStyle(
              color: CustomColors.customBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselCards(
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
                    return ref.watch(GameplaysProvider.accountGameplaysProvider(selectedCard.accountId ?? 0)).maybeWhen(
                          orElse: () => Container(),
                          loading: () => const Center(child: CircularProgressIndicator.adaptive()),
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
                                  text: SplashScreenNotifier.getLanguageLabel('This card has no gameplays'),
                                  fontSize: 30.0,
                                ),
                              );
                            }
                            return ListView.builder(
                              itemCount: data.length,
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        MulishText(text: '${item.game}', fontSize: 16, fontWeight: FontWeight.bold),
                                        MulishText(
                                          text: DateFormat('MMM d, yyyy, h:mm a').format(DateTime.parse(item.playDate ?? "")),
                                          fontSize: 14,
                                          fontColor: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    onTap: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                        title: Column(children: <Widget>[
                                          MulishText(
                                            text: '${item.game}',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          MulishText(
                                            text: SplashScreenNotifier.getLanguageLabel("Balance consumed during gameplay"),
                                            fontSize: 12,
                                            fontColor: Colors.grey,
                                          ),
                                        ]),
                                        content: SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.25,
                                          width: MediaQuery.of(context).size.height * 0.30,
                                          child: GridView(
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: (100 / 70),
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 20,
                                              ),
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: CustomColors.hardOrange, gradient: CustomGradients.linearGradient),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(12.0),
                                                        color: Colors.white,
                                                      ),
                                                      margin: const EdgeInsets.all(3),
                                                      child: TextButton(
                                                        onPressed: () {},
                                                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                                          MulishText(
                                                            text: item.credits.toInt().toString(),
                                                            fontSize: 25,
                                                            fontColor: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          MulishText(
                                                            text: SplashScreenNotifier.getLanguageLabel("Credits"),
                                                            fontSize: 14,
                                                            fontColor: Colors.grey,
                                                          ),
                                                        ]),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: CustomColors.hardOrange, gradient: CustomGradients.linearGradient),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(12.0),
                                                        color: Colors.white,
                                                      ),
                                                      margin: const EdgeInsets.all(3),
                                                      child: TextButton(
                                                        onPressed: () {},
                                                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                                          MulishText(
                                                            text: item.bonus.toInt().toString(),
                                                            fontSize: 25,
                                                            fontColor: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          MulishText(
                                                            text: SplashScreenNotifier.getLanguageLabel("Bonus"),
                                                            fontSize: 14,
                                                            fontColor: Colors.grey,
                                                          ),
                                                        ]),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: CustomColors.hardOrange, gradient: CustomGradients.linearGradient),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(12.0),
                                                        color: Colors.white,
                                                      ),
                                                      margin: const EdgeInsets.all(3),
                                                      child: TextButton(
                                                        onPressed: () {},
                                                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                                          MulishText(
                                                            text: item.time.toInt().toString(),
                                                            fontSize: 25,
                                                            fontColor: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          MulishText(
                                                            text: SplashScreenNotifier.getLanguageLabel("Time"),
                                                            fontSize: 14,
                                                            fontColor: Colors.grey,
                                                          ),
                                                        ]),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: CustomColors.hardOrange, gradient: CustomGradients.linearGradient),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(12.0),
                                                        color: Colors.white,
                                                      ),
                                                      margin: const EdgeInsets.all(3),
                                                      child: TextButton(
                                                        onPressed: () {},
                                                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                                          MulishText(
                                                            text: item.courtesy.toInt().toString(),
                                                            fontSize: 25,
                                                            fontColor: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          MulishText(
                                                            text: SplashScreenNotifier.getLanguageLabel("Card Game"),
                                                            fontSize: 14,
                                                            fontColor: Colors.grey,
                                                          ),
                                                        ]),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                        actions: <Widget>[
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.80,
                                            child: ElevatedButton(
                                              onPressed: () => Navigator.pop(context, 'OK'),
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.zero, backgroundColor: CustomColors.hardOrange, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                              child: Ink(
                                                decoration: BoxDecoration(color: CustomColors.hardOrange, gradient: CustomGradients.linearGradient, borderRadius: BorderRadius.circular(10)),
                                                child: Container(
                                                  height: 40,
                                                  alignment: Alignment.center,
                                                  child: MulishText(
                                                    text: SplashScreenNotifier.getLanguageLabel("Done"),
                                                    fontColor: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
}
