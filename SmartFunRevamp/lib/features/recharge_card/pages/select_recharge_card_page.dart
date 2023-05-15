import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/buy_a_card/pages/estimated_transaction_page.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/recharge_card/providers/products_price_provider.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_bottom_sheet_button.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_card_offers.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class SelectCardRechargePage extends ConsumerStatefulWidget {
  const SelectCardRechargePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectCardRechargePageState();
}

class _SelectCardRechargePageState extends ConsumerState<SelectCardRechargePage> {
  CardProduct? offerSelected;
  late CardDetails selectedCardNumber;
  late List<CardDetails> cards;
  late int userSite;
  @override
  void initState() {
    super.initState();
    cards = List<CardDetails>.from(ref.read(CardsProviders.userCardsProvider).value ?? []);
    cards.removeWhere((element) => element.isBlocked() || element.isExpired());
    selectedCardNumber = cards.first;
    userSite = ref.read(loginProvider.notifier).selectedSite?.siteId ?? 1040;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      bottomSheet: BottomSheetButton(
        label: SplashScreenNotifier.getLanguageLabel('RECHARGE NOW'),
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
                ),
              ),
            );
          }
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    return ref.watch(rechargeProductsProvider(userSite)).maybeWhen(
                          orElse: () => Container(),
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (error, stackTrace) => const MulishText(text: 'Error'),
                          data: (offers) {
                            return RechargeCardOffers(
                              offers: offers,
                              onOfferSelected: (offer) {
                                offerSelected = offer;
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
}
