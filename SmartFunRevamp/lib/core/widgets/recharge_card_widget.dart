import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class RechargeCardWidget extends ConsumerWidget {
  const RechargeCardWidget({Key? key, required this.cardProduct}) : super(key: key);
  final CardProduct cardProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parafaitDefault = ref.watch(parafaitDefaultsProvider).value;
    final currencySymbol = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencySymbol) ?? 'USD';
    final currencyFormat = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencyFormat) ?? '#,##0.00';
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardProduct.productName,
                style: GoogleFonts.mulish(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    cardProduct.finalPrice.toCurrency(currencySymbol, currencyFormat),
                    style: GoogleFonts.mulish(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    cardProduct.basePrice.toCurrency(currencySymbol, currencyFormat),
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
                '$discount % ${SplashScreenNotifier.getLanguageLabel('OFF')}',
                style: GoogleFonts.mulish(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            SplashScreenNotifier.getLanguageLabel('Valid for 11 months from date of purchase'),
            style: const TextStyle(
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
