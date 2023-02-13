import 'package:flutter/material.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_card_offer.dart';

class RechargeCardOffers extends StatefulWidget {
  const RechargeCardOffers({
    Key? key,
    required this.offers,
    required this.onOfferSelected,
  }) : super(key: key);
  final List<CardProduct> offers;
  final Function(CardProduct) onOfferSelected;
  @override
  State<RechargeCardOffers> createState() => _RechargeCardOffersState();
}

class _RechargeCardOffersState extends State<RechargeCardOffers> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: widget.offers.length,
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(height: 10.0),
      itemBuilder: (context, index) {
        final offer = widget.offers[index];
        return RechargeCardOffer(
          offer: offer,
          isSelected: selectedIndex == index,
          onTap: () {
            widget.onOfferSelected(offer);
            setState(() {
              selectedIndex = index;
            });
          },
        );
      },
    );
  }
}
