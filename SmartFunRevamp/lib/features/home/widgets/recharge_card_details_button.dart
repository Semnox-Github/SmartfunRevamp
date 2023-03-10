import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/features/cards_detail/card_detail_page.dart';

class RechargeCardDetailsButton extends StatelessWidget {
  const RechargeCardDetailsButton({
    Key? key,
    required this.cardDetails,
  }) : super(key: key);
  final CardDetails cardDetails;

  @override
  Widget build(BuildContext context) {
    if (!cardDetails.accountNumber!.startsWith('T')) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: CustomGradients.linearGradient,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: CustomGradients.linearGradient,
                ),
                margin: const EdgeInsets.all(3),
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, Routes.kRechargePageCard),
                  child: const Text(
                    'RECHARGE NOW',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: CustomGradients.linearGradient,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.all(3),
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardDetailPage(cardDetails: cardDetails),
                    ),
                  ),
                  child: const Text(
                    'CARD DETAILS',
                    style: TextStyle(
                      color: CustomColors.hardOrange,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  else {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                'Your card ${cardDetails.accountNumber} has been blocked, based on your request. You no longer will be to use it.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                ' This card will be removed from smartfun once you get the new physical card.',
                textAlign: TextAlign.center,
                 style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        
      ]
    );
  }
  }
}
