import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import 'package:intl/intl.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/widgets/background_card_details.dart';

class CarouselCards extends StatelessWidget {
  const CarouselCards({
    Key? key,
    required this.cards,
    required this.onCardChanged,
  }) : super(key: key);
  final Function(CardDetails) onCardChanged;
  final List<CardDetails> cards;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: InfiniteCarousel.builder(
        itemCount: cards.length,
        itemExtent: 330,
        center: true,
        anchor: 0.0,
        velocityFactor: 0.2,
        onIndexChanged: (index) {
          onCardChanged(cards[index]);
        },
        axisDirection: Axis.horizontal,
        loop: false,
        itemBuilder: (context, itemIndex, realIndex) {
          final card = cards[itemIndex];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BackgroundCard(
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
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/home/QR.png',
                          height: 42.0,
                        )
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(
                              width: 1.5,
                              color: Colors.white,
                            ),
                          ),
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
                      '${card.issueDate != null ? DateFormat('dd  MMM yyyy').format(card.issueDate as DateTime) : ''} ${card.expiryDate != null ? DateFormat('- dd  MMM yyyy').format(card.expiryDate as DateTime) : ''}',
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
      ),
    );
  }
}
