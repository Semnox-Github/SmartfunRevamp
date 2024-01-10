import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/data/datasources/local_data_source.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/entities/orders/order_details.dart';
import 'package:semnox/core/domain/entities/orders/order_status.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/buy_a_card/pages/estimated_transaction_page.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/view/home_view.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';
import 'package:semnox/features/orders/provider/orders_provider.dart';
import 'package:semnox/features/recharge_card/providers/products_price_provider.dart';
import 'package:semnox/features/recharge_card/widgets/disabled_bottom_button.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_bottom_sheet_button.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_card_offers.dart';
import 'package:semnox/features/recharge_card/widgets/site_dropdown.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

import '../../../core/widgets/custom_app_bar.dart';

class SelectCardRechargePage extends ConsumerStatefulWidget {
  final String? filterStr;
  const SelectCardRechargePage({Key? key, this.filterStr}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectCardRechargePageState();
}

class _SelectCardRechargePageState
    extends ConsumerState<SelectCardRechargePage> {
  CardProduct? offerSelected;
  late CardDetails? selectedCardNumber;
  late List<CardDetails> cards;
  late int qty;
  late double finalPrice;
  late CardDetails? cardDetails;
  late List<OrderStatus> orderStatus;
  late OrderDetails orderDetails;
  late int transactionId;

  Future<void> amountSelectorDialog(BuildContext context) {
    TextEditingController txt = TextEditingController();
    txt.text = "";
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(SplashScreenNotifier.getLanguageLabel(
              'Enter the variable amount')),
          content: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
            controller: txt,
            decoration: InputDecoration(
              hintText: SplashScreenNotifier.getLanguageLabel(
                  'Please enter the amount you wish to recharge'),
            ),
            onChanged: (amount) {
              setState(() {
                finalPrice =
                    double.tryParse(amount) == null ? 0 : double.parse(amount);
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
                handleProductSelection(context);
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

  void handleProductSelection(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    ref.read(OrdersProviders.customerOrderStatusProvider.notifier);
    GluttonLocalDataSource()
        .retrieveValue(LocalDataSource.kTransactionId)
        .then((value) async => {
              if (value != null)
                {
                  Dialogs.lastTransactionDialog(context, ref, value.toString()),
                }
            });

    final parafaitDefault = ref.watch(parafaitDefaultsProvider);
    final currency =
        parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencySymbol) ??
            'USD';
    final format =
        parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencyFormat) ??
            '#,##0.00';

    return Scaffold(
      appBar: widget.filterStr == null
          ? CustomAppBar(
              title: SplashScreenNotifier.getLanguageLabel('Recharge a Card'),
            )
          //  AppBar(
          //     title: Text(
          //       SplashScreenNotifier.getLanguageLabel('Recharge a Card'),
          //       style: const TextStyle(
          //         color: CustomColors.customBlue,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     shape: const RoundedRectangleBorder(),
          //   )
          : null,
      // bottomSheet: offerSelected != null && selectedCardNumber != null
      //     ? BottomSheetButton(
      //         label: offerSelected == null
      //             ? SplashScreenNotifier.getLanguageLabel('RECHARGE NOW')
      //             : '${SplashScreenNotifier.getLanguageLabel('RECHARGE NOW')} \$ ${(qty * finalPrice).toCurrency(currency, format)}',
      //         onTap: () {
      //           if (offerSelected != null) {
      //             Navigator.pop(context);
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => EstimatedTransactionPage(
      //                   cardProduct: offerSelected!,
      //                   cardSelected: selectedCardNumber,
      //                   transactionType: "recharge",
      //                   qty: qty,
      //                   finalPrice: finalPrice,
      //                 ),
      //               ),
      //             );
      //           }
      //         },
      //       )
      //     : DisabledBottomButton(
      // label: SplashScreenNotifier.getLanguageLabel('RECHARGE NOW')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(
              builder: (_, ref, __) {
                final defaults = ref.watch(parafaitDefaultsProvider);
                final isOnlineRechargeEnabled = defaults?.getDefault(
                        ParafaitDefaultsResponse.onlineRechargeEnabledKey) ==
                    'Y';
                final virtualStoreSiteId = defaults
                    ?.getDefault(ParafaitDefaultsResponse.virtualStoreSiteId);
                return SitesAppBarDropdown(
                  isEnabled:
                      isOnlineRechargeEnabled && (virtualStoreSiteId == null),
                  onChanged: (selectedSite) {
                    ref
                        .read(selectedSiteIdProvider.notifier)
                        .update((state) => state = selectedSite?.siteId ?? -1);
                  },
                );
              },
            ),
            cardDetails != null
                ? CarouselCardItem(
                    card: selectedCardNumber ?? CardDetails(),
                  )
                : CarouselCards(
                    cards: cards,
                    onCardChanged: (index) {
                      selectedCardNumber = cards[index];
                    },
                    showLinkCard: false,
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: MulishText(
                text: SplashScreenNotifier.getLanguageLabel(
                    'Exclusive Offers on Recharges'),
                textAlign: TextAlign.start,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Container(
                //margin: const EdgeInsets.only(bottom: 100.0),
                child: Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(rechargeProductsProvider).maybeWhen(
                          orElse: () => Container(),
                          loading: () => const Center(
                              child: CircularProgressIndicator.adaptive()),
                          error: (error, stackTrace) =>
                              const MulishText(text: 'Error'),
                          data: (offers) {
                            offers.sort((a, b) {
                              final sortOrderA = a.sortOrder as double?;
                              final sortOrderB = b.sortOrder as double?;

                              if (sortOrderA == null && sortOrderB == null) {
                                return 0; // If both are null, leave them unchanged relative to each other
                              } else if (sortOrderA == null) {
                                return 1; // Null values go to the end
                              } else if (sortOrderB == null) {
                                return -1; // Null values go to the end
                              } else {
                                return sortOrderA.compareTo(sortOrderB);
                              }
                            });
                            List<CardProduct> offersFiltered = offers;
                            if (!widget.filterStr.isNullOrEmpty()) {
                              offersFiltered = offers
                                  .where((element) => (element.productName
                                      .toLowerCase()
                                      .contains(widget.filterStr
                                          .toString()
                                          .toLowerCase())))
                                  .toList();
                            }

                            // print("offers ***** $offersFiltered");
                            return RechargeCardOffers(
                              offers: offersFiltered,
                              onOfferSelected: (offer) {
                                if (selectedCardNumber != null) {
                                  setState(() {
                                    offerSelected = offer;
                                    finalPrice = offerSelected!.finalPrice;
                                    qty = 1;
                                  });
                                  handleProductSelection(context);
                                  if (offer.productType == "VARIABLECARD") {
                                    amountSelectorDialog(context);
                                  } else if (offer.QuantityPrompt == "Y") {
                                    qtySelectorDialog(context);
                                  }
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

  @override
  void initState() {
    super.initState();
    cardDetails = ref.read(currentCardProvider);
    //if a card was selected from home screen
    if (cardDetails != null) {
      //is added to cards list as the only card
      List<CardDetails> selectedCard = [];
      selectedCard.add(cardDetails!);
      cards = selectedCard;
    } else {
      //if no card was selected, i.e. when landed from Search, get all the user cards
      cards = List<CardDetails>.from(
          ref.read(CardsProviders.userCardsProvider).value ?? []);
      cards
          .removeWhere((element) => element.isBlocked() || element.isExpired());
    }
    if (cards.isNotEmpty) {
      selectedCardNumber = cards.first;
    }
    qty = 1;
    finalPrice = 0;
  }

  Future<void> qtySelectorDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(SplashScreenNotifier.getLanguageLabel('Enter the quantity')),
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
                handleProductSelection(context);
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
}
