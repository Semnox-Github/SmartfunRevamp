import 'package:flutter/material.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';

class FromSelectionContainer extends StatelessWidget {
  const FromSelectionContainer({
    super.key,
    required this.cards,
    required this.onCardChanged,
  });

  final List<CardDetails> cards;
  final Function(int) onCardChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MulishText(
          text: 'Transfer From',
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 10.0),
        CarouselCards(
          showLinkCard: false,
          cards: cards,
          onCardChanged: onCardChanged,
        ),
      ],
    );
  }
}
