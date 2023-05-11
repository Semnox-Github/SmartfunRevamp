import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/buy_a_card/pages/estimated_transaction_page.dart';
import 'package:semnox/features/buy_a_card/provider/buy_card/buy_card_notifier.dart';
import 'package:semnox/features/buy_a_card/widgets/card_type.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/recharge_card/providers/products_price_provider.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_bottom_sheet_button.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_card_offers.dart';
import 'package:semnox/features/select_location/pages/select_location_manually_page.dart';

import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';


class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  CardProduct? offerSelected;
  late CardDetails selectedCardNumber;
  late List<CardDetails> cards;
  late int userSite;
  late List<CardProduct> newCards = [];
  late List<CardProduct> recharges = [];
  late List<CardProduct> newCardsFiltered = [];
  late List<CardProduct> rechargesFiltered = [];
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
          SplashScreenNotifier.getLanguageLabel('Search'),
          style: const TextStyle(
            color: CustomColors.customBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomSheet: BottomSheetButton(
        label: SplashScreenNotifier.getLanguageLabel('Buy Now'),
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
            const SizedBox( height: 10,),
            SearchTextField(
                onChanged: (filter) => {
                  setState((){
                    if(filter.isEmpty) {
                      newCardsFiltered = [];
                      rechargesFiltered = [];
                    } else {
                      newCardsFiltered = newCards.where((element) => (element.productName.toLowerCase().contains(filter.toLowerCase()))).toList();
                      rechargesFiltered = recharges.where((element) => (element.productName.toLowerCase().contains(filter.toLowerCase()))).toList();
                    }
                  })                 
                },
              ),
              const SizedBox( height: 10,),
            // CarouselCards(
            //   cards: cards,
            //   onCardChanged: (index) {
            //     selectedCardNumber = cards[index];
            //   },
            //   showLinkCard: false,
            // ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
            //   child: MulishText(
            //     text: 'Exclusive Offers on Recharges',
            //     textAlign: TextAlign.start,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 100.0),
                child: Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(allProductsProvider(userSite)).maybeWhen(
                          orElse: () => Container(),
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (error, stackTrace) => const MulishText(text: 'Error'),
                          data: (offers) {
                            newCards = offers.where((element) => element.productType == "CARDSALE" || element.productType == "NEW").toList();
                            recharges = offers.where((element) => (element.productType == "RECHARGE")).toList();
                            return RechargeCardOffers(
                              offers: rechargesFiltered,
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
