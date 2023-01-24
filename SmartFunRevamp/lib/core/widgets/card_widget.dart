import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';

class RechargeCardWidget extends StatelessWidget {
  const RechargeCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                'Platinum',
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
                    '\$90',
                    style: GoogleFonts.mulish(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    '\$100',
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
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '10% OFF',
                style: GoogleFonts.mulish(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
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
                '1000 CREDITS',
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
