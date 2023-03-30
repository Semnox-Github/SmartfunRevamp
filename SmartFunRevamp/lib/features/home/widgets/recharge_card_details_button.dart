import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/features/cards_detail/card_detail_page.dart';

class RechargeCardDetailsButton extends StatelessWidget {
  RechargeCardDetailsButton({
    Key? key,
    required this.cardDetails,
  }) : super(key: key);
  late final CardDetails cardDetails;
  late final DateTime timeNow = DateTime.now();
  late final DateTime expirationDate = cardDetails.expiryDate!= null ? DateTime.parse(cardDetails.expiryDate.toString()) : timeNow;
  late final int daysUntilExpiration = (expirationDate.difference(timeNow).inHours / 24).round();

  @override
  
  Widget build(BuildContext context) {
    if (daysUntilExpiration < 0) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Expanded(
          child: Column(
            children: [
              Text(
                'This card has expired on ${DateFormat('dd MMM yyyy').format(expirationDate)}\n',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.red
                ),
              ),
              const Text(
                'You will no longer be able to use this card. But you can still view the Gameplay history and Activity details.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ]);
    }
    else if (!cardDetails.accountNumber!.startsWith('T')) {
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
    } else {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
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
      ]);
    }
  }
}
