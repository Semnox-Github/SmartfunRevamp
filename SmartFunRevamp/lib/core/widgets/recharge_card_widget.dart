import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';

class RechargeCardWidget extends StatelessWidget {
  const RechargeCardWidget({Key? key, required this.cardProduct}) : super(key: key);
  final CardProduct cardProduct;

  @override
  Widget build(BuildContext context) {
    double discount = ((cardProduct.basePrice - cardProduct.finalPrice) * 100) / cardProduct.basePrice;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: CustomGradients.platimunGradient,
        borderRadius: BorderRadius.circular(
          20.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardProduct.productName.substring(0, cardProduct.productName.length < 16 ? cardProduct.productName.length : 16),
                style: GoogleFonts.mulish(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '\$${cardProduct.finalPrice.toStringAsFixed(0)}',
                    style: GoogleFonts.mulish(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    '\$${cardProduct.basePrice.toStringAsFixed(0)}',
                    style: GoogleFonts.mulish(
                      color: CustomColors.customLigthGray,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${discount.toStringAsFixed(0)} % OFF',
                style: GoogleFonts.mulish(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/buy_card/coin.svg',
                color: Colors.white,
              ),
              const SizedBox(width: 5.0),
              Text(
                '${cardProduct.credits.toStringAsFixed(0)} CREDITS',
                style: GoogleFonts.mulish(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Valid for 11 months from date of purchase',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
