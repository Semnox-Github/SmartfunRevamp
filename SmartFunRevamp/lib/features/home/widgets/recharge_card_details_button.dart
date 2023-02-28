import 'package:flutter/material.dart';
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
    return Row(
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
    );
  }
}
