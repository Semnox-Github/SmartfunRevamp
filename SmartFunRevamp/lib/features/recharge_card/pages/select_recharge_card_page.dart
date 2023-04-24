import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/buy_a_card/pages/estimated_transaction_page.dart';
import 'package:semnox/features/recharge_card/providers/products_price_provider.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_bottom_sheet_button.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_card_offers.dart';
import 'package:semnox/features/recharge_card/widgets/user_cards.dart';

class SelectCardRechargePage extends StatefulWidget {
  const SelectCardRechargePage({Key? key}) : super(key: key);

  @override
  State<SelectCardRechargePage> createState() => _SelectCardRechargePageState();
}

class _SelectCardRechargePageState extends State<SelectCardRechargePage> {
  late CardDetails selectedCardNumber;
  CardProduct? offerSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFF8FF),
        elevation: 0.0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Recharge a Card',
          style: TextStyle(
            color: CustomColors.customBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomSheet: BottomSheetButton(
        label: 'RECHARGE NOW',
        onTap: () {
          if (offerSelected != null) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EstimatedTransactionPage(cardProduct: offerSelected!, cardSelected: selectedCardNumber, transactionType: "recharge"),
              ),
            );
          }
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserCards(
              onCardSelected: (card) {
                selectedCardNumber = card;
              },
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
                    return ref.watch(rechargeProductsProvider).maybeWhen(
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
