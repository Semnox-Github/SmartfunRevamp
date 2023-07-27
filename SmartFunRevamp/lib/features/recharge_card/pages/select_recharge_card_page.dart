import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/buy_a_card/pages/estimated_transaction_page.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';
import 'package:semnox/features/recharge_card/providers/products_price_provider.dart';
import 'package:semnox/features/recharge_card/widgets/disabled_bottom_button.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_bottom_sheet_button.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_card_offers.dart';
import 'package:semnox/features/recharge_card/widgets/site_dropdown.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

final selectedProvider = StateProvider<int>((ref) {
  return -1;
});

class SelectCardRechargePage extends ConsumerStatefulWidget {
  const SelectCardRechargePage({Key? key, this.filterStr, this.cardDetails}) : super(key: key);

  final String? filterStr;
  final CardDetails? cardDetails;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectCardRechargePageState();
}

class _SelectCardRechargePageState extends ConsumerState<SelectCardRechargePage> {
  CardProduct? offerSelected;
  late CardDetails selectedCardNumber;
  late List<CardDetails> cards;

  late int qty;
  late double finalPrice;
  @override
  void initState() {
    super.initState();
    //if a card was selected from home screen
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
    selectedCardNumber = cards.first;
    qty = 1;
    finalPrice = 0;
  }

  @override
  Widget build(BuildContext context) {
    final parafaitDefault = ref.watch(parafaitDefaultsProvider).value;
    final currency = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencySymbol) ?? 'USD';
    final format = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencyFormat) ?? '#,##0.00';

    return Scaffold(
      appBar: widget.filterStr == null
          ? AppBar(
              backgroundColor: const Color(0xFFCFF8FF),
              elevation: 0.0,
              centerTitle: false,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Text(
                SplashScreenNotifier.getLanguageLabel('Recharge a Card'),
                style: const TextStyle(
                  color: CustomColors.customBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      bottomSheet: offerSelected != null
          ? BottomSheetButton(
              label: offerSelected == null
                  ? SplashScreenNotifier.getLanguageLabel('RECHARGE NOW')
                  : '${SplashScreenNotifier.getLanguageLabel('RECHARGE NOW')} \$ ${(qty * finalPrice).toCurrency(currency, format)}',
              onTap: () {
                Logger().d(offerSelected);
                if (offerSelected != null) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EstimatedTransactionPage(
                        cardProduct: offerSelected!,
                        cardSelected: selectedCardNumber,
                        transactionType: "recharge",
                        qty: qty,
                        finalPrice: finalPrice,
                      ),
                    ),
                  );
                }
              },
            )
          : DisabledBottomButton(label: SplashScreenNotifier.getLanguageLabel('RECHARGE NOW')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(
              builder: (_, ref, __) {
                final defaults = ref.watch(parafaitDefaultsProvider).value;
                final isOnlineRechargeEnabled = defaults?.getDefault(ParafaitDefaultsResponse.onlineRechargeEnabledKey) == 'Y';
                return SitesAppBarDropdown(
                  isEnabled: isOnlineRechargeEnabled,
                  onChanged: (selectedSite) {
                    ref.read(selectedProvider.notifier).update((state) => state = selectedSite?.siteId ?? -1);
                  },
                );
              },
            ),
            CarouselCards(
              cards: cards,
              onCardChanged: (index) {
                selectedCardNumber = cards[index];
              },
              showLinkCard: false,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: MulishText(
                text: 'Exclusive Offers on Recharges',
                textAlign: TextAlign.start,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 100.0),
                child: Consumer(
                  builder: (context, ref, child) {
                    final selectedSite = ref.watch(selectedProvider);
                    if (selectedSite == -1) {
                      return Container(
                        height: 100,
                        width: 100,
                        color: Colors.red,
                      );
                    }
                    return ref.watch(rechargeProductsProvider(selectedSite)).maybeWhen(
                          orElse: () => Container(),
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (error, stackTrace) => const MulishText(text: 'Error'),
                          data: (offers) {
                            List<CardProduct> offersFiltered = offers;
                            if (!widget.filterStr.isNullOrEmpty()) {
                              offersFiltered = offers.where((element) => (element.productName.toLowerCase().contains(widget.filterStr.toString().toLowerCase()))).toList();
                            }
                            return RechargeCardOffers(
                              offers: offersFiltered,
                              onOfferSelected: (offer) {
                                setState(() {
                                  offerSelected = offer;
                                  finalPrice = offerSelected!.finalPrice;
                                  qty = 1;
                                });
                                if (offer.productType == "VARIABLECARD") {
                                  amountSelectorDialog(context);
                                } else if (offer.QuantityPrompt == "Y") {
                                  qtySelectorDialog(context);
                                }
                              },
                            );
                          },
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> qtySelectorDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(SplashScreenNotifier.getLanguageLabel('Enter the quantity')),
          content: SpinBox(
            min: 1,
            max: 100,
            value: qty.toDouble(),
            onChanged: (value) => {
              setState(() {
                qty = value.toInt();
              })
            },
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const MulishText(
                text: 'Done',
                fontWeight: FontWeight.bold,
                fontColor: CustomColors.hardOrange,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const MulishText(
                text: 'Cancel',
                fontWeight: FontWeight.bold,
                fontColor: CustomColors.hardOrange,
              ),
              onPressed: () {
                setState(() {
                  qty = 1;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> amountSelectorDialog(BuildContext context) {
    TextEditingController txt = TextEditingController();
    txt.text = "";
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(SplashScreenNotifier.getLanguageLabel('Enter the variable amount')),
          content: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly], // Only numbers can be entered
            controller: txt,
            decoration: InputDecoration(hintText: SplashScreenNotifier.getLanguageLabel('Please enter the amount you wish to recharge')),
            onChanged: (amount) {
              setState(() {
                finalPrice = double.tryParse(amount) == null ? 0 : double.parse(amount);
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const MulishText(
                text: 'Done',
                fontWeight: FontWeight.bold,
                fontColor: CustomColors.hardOrange,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const MulishText(
                text: 'Cancel',
                fontWeight: FontWeight.bold,
                fontColor: CustomColors.hardOrange,
              ),
              onPressed: () {
                setState(() {
                  finalPrice = 0;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
