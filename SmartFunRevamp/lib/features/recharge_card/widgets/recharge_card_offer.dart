import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class RechargeCardOffer extends ConsumerWidget {
  const RechargeCardOffer({
    Key? key,
    required this.offer,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final CardProduct offer;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double discount = offer.basePrice != 0 ? (((offer.basePrice - offer.finalPrice) * 100) / offer.basePrice) : 0;
    final parafaitDefault = ref.watch(parafaitDefaultsProvider).value;
    final currency = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencySymbol) ?? 'USD';
    final format = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencyFormat) ?? '#,##0.00';
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.customLigthBlue,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            //RIGTH
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.productName,
                      style: GoogleFonts.mulish(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/buy_card/coin.svg'),
                        const SizedBox(width: 5.0),
                        Text(
                          offer.credits.toStringAsFixed(0),
                          style: GoogleFonts.mulish(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ), //LEFT
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  border: Border.all(
                    width: 2,
                    color: isSelected ? Colors.green : CustomColors.customLigthGray,
                  ),
                ),
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.all(1.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        offer.basePrice == offer.finalPrice
                            ? Row(
                                children: [
                                  Text(
                                    offer.basePrice.toCurrency(currency, format),
                                    style: GoogleFonts.mulish(
                                      color: CustomColors.discountColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    '${discount.toStringAsFixed(0)}% ${SplashScreenNotifier.getLanguageLabel('OFF')}',
                                    style: GoogleFonts.mulish(
                                      color: CustomColors.discountPercentColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              )
                            : const Row(),
                        Text(
                          offer.finalPrice.toCurrency(currency, format),
                          style: GoogleFonts.mulish(
                            fontWeight: FontWeight.w800,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    if (isSelected)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
