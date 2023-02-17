import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/routes.dart';

class RechargeCardDetailsButton extends StatelessWidget {
  const RechargeCardDetailsButton({
    Key? key,
  }) : super(key: key);

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
                onPressed: () {},
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
