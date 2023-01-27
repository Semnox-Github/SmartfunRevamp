import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/widgets/card_widget.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/features/buy_a_card/pages/estimated_transaction_page.dart';
import 'package:semnox/features/buy_a_card/provider/buy_card_notifier.dart';

enum CardValue { silver, gold, platinum }

extension CardValueExtension on CardValue {
  String get name {
    switch (this) {
      case CardValue.silver:
        return 'SILVER';
      case CardValue.gold:
        return 'GOLD';
      case CardValue.platinum:
        return 'PLATINUM';
      default:
        return '';
    }
  }

  Gradient get colorGradient {
    switch (this) {
      case CardValue.silver:
        return CustomGradients.silverCircularGradient;
      case CardValue.gold:
        return CustomGradients.goldenCircularGradient;
      case CardValue.platinum:
        return CustomGradients.platimunGradient;
      default:
        return CustomGradients.disabledGradient;
    }
  }
}

CardValue randomCard() {
  int diceRoll = Random().nextInt(6) + 1;
  switch (diceRoll) {
    case 1:
      return CardValue.silver;
    case 2:
      return CardValue.silver;
    case 3:
      return CardValue.gold;
    case 4:
      return CardValue.gold;
    case 5:
      return CardValue.platinum;
    case 6:
      return CardValue.platinum;
    default:
      return CardValue.silver;
  }
}

class CardType extends ConsumerWidget {
  const CardType({Key? key, required this.card}) : super(key: key);
  final CardProduct card;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CardValue value = randomCard();
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              content: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: CustomColors.customLigthBlue,
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Platinum 1000',
                              style: GoogleFonts.mulish(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.cancel_outlined,
                              ),
                            )
                          ],
                        ),
                      ),
                      RechargeCardWidget(cardProduct: card),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Features & Terms',
                              style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w800,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              '\u2022 Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                              style: GoogleFonts.mulish(
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              '\u2022 Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                              style: GoogleFonts.mulish(
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              '\u2022 Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                              style: GoogleFonts.mulish(
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              '\u2022 Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                              style: GoogleFonts.mulish(
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            CustomButton(
                              onTap: () {
                                ref.listenManual(
                                  estimateProvider(card),
                                  (previous, next) {
                                    next.maybeWhen(
                                      orElse: () => Logger().d('else'),
                                      data: (data) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EstimatedTransactionPage(
                                            transactionResponse: data,
                                            cardProduct: card,
                                          ),
                                        ),
                                      ),
                                      error: (error, stackTrace) => Logger().e(error),
                                      loading: () => Logger().d('Loading'),
                                    );
                                  },
                                  fireImmediately: true,
                                );
                              },
                              label: 'BUY NOW @ ${card.finalPrice}',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Stack(
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(
              horizontal: 50.0,
            ),
            margin: const EdgeInsets.only(left: 80.0, right: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: CustomColors.customLigthGray,
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$${card.finalPrice}',
                  style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w800,
                    fontSize: 20.0,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '\$${card.basePrice}',
                      style: GoogleFonts.mulish(
                        color: CustomColors.discountColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      '10% OFF',
                      style: GoogleFonts.mulish(
                        color: CustomColors.discountPercentColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              margin: const EdgeInsets.all(3.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 75,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: value.colorGradient,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.productName,
                    style: GoogleFonts.mulish(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/buy_card/coin.svg'),
                      const SizedBox(width: 5.0),
                      Text(
                        card.credits.toString(),
                        style: GoogleFonts.mulish(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
