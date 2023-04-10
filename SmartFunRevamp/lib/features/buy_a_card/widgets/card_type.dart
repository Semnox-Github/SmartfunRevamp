import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

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
    double discount = ((card.basePrice - card.finalPrice) * 100) / card.basePrice;
    return GestureDetector(
      onTap: () => Dialogs.showCardInfo(context, card),
      child: Stack(
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(
              horizontal: 75.0,
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
                Row(children: [
                  MulishText(
                    text: '\$${card.finalPrice.toStringAsFixed(0)}',
                    fontWeight: FontWeight.w800,
                    fontSize: 20.0,
                  ),
                ]),
                card.basePrice == card.finalPrice
                    ? Row(
                        children: [
                          MulishText(
                            text: '\$${card.basePrice.toStringAsFixed(0)}',
                            fontColor: CustomColors.discountColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            textDecoration: TextDecoration.lineThrough,
                          ),
                          const SizedBox(width: 8.0),
                          MulishText(
                            text: '${discount.toStringAsFixed(0)} % OFF',
                            fontColor: CustomColors.discountPercentColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ],
                      )
                    : Row()
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
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.37,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: value.colorGradient,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MulishText(
                    text: card.productName,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/buy_card/coin.svg'),
                      const SizedBox(width: 5.0),
                      MulishText(
                        text: card.credits.toString(),
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
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
