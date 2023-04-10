import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/background_card_details.dart';
import 'package:semnox/features/home/widgets/link_a_card.dart';

class CarouselCards extends StatelessWidget {
  const CarouselCards({
    Key? key,
    required this.cards,
    required this.onCardChanged,
    this.showLinkCard = true,
  }) : super(key: key);
  final Function(int) onCardChanged;
  final List<CardDetails> cards;
  final bool showLinkCard;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        enableInfiniteScroll: false,
        height: MediaQuery.of(context).size.height * 0.25,
        viewportFraction: 1,
        onPageChanged: (index, _) => onCardChanged(index),
      ),
      itemCount: cards.length + (showLinkCard ? 1 : 0),
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        if (itemIndex == cards.length && showLinkCard) {
          return LinkACard();
        }
        final card = cards[itemIndex];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BackgroundCard(
              isVirtual: card.isBlocked(),
              isExpired: card.isExpired(),
              cardNumber: card.accountNumber!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${card.accountNumber}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 7.0),
                          Text(
                            '${card.accountIdentifier == '' ? '+ Add nickname' : card.accountIdentifier?.substring(0, 15)}',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Dialogs.showBarcodeTempCard(context, card.accountNumber!),
                        child: Image.asset(
                          'assets/home/QR.png',
                          height: 42.0,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 1.0, color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'Get Balance',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    '${card.issueDate != null ? DateFormat('dd  MMM yyyy').format(card.issueDate as DateTime) : ''} ${card.expiryDate != null ? DateFormat('- dd  MMM yyyy').format(DateTime.parse(card.expiryDate.toString())) : ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
