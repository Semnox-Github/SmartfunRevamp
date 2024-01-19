import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

import '../../../core/utils/dialogs.dart';
import '../../../core/widgets/mulish_text.dart';
import '../../buy_a_card/widgets/card_type.dart';
import '../../home/view/home_view.dart';

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

  CardsColor? get cardColors => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Image File Name ${offer.imageFileName}");
    double discount = offer.basePrice != 0
        ? (((offer.basePrice - offer.finalPrice) * 100) / offer.basePrice)
        : 0;
    final parafaitDefault = ref.watch(parafaitDefaultsProvider);
    final currency =
        parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencySymbol) ??
            'USD';
    final format =
        parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencyFormat) ??
            '#,##0.00';

    final colors = randomCard(cardColors);

    final String baseUrl = Get.find<String>(tag: 'baseURL');

    print(
        "image URL:$baseUrl/APP_PRODUCT_IMAGES_FOLDER/${offer.imageFileName?.trim()}");
    // return InkWell(
    //   onTap: onTap,
    //   child: Container(
    //     decoration: BoxDecoration(
    //       color: CustomColors.customLigthBlue,
    //       borderRadius: BorderRadius.circular(20.0),
    //     ),
    //     child: Row(
    //       children: [
    //         //RIGTH

    //         // Expanded(
    //         //   flex: 1,
    //         //   child: Container(
    //         //     padding: const EdgeInsets.all(15.0),
    //         //     child: Column(
    //         //       mainAxisSize: MainAxisSize.min,
    //         //       mainAxisAlignment: MainAxisAlignment.center,
    //         //       crossAxisAlignment: CrossAxisAlignment.start,
    //         //       children: [
    //         //         Text(
    //         //           offer.description,
    //         //           style: GoogleFonts.mulish(
    //         //             fontWeight: FontWeight.bold,
    //         //             fontSize: 12.0,
    //         //           ),
    //         //         ),
    //         //       ],
    //         //     ),
    //         //   ),
    //         // ), //LEFT

    //         Expanded(
    //           flex: 1,
    //           child: Container(
    //             padding: const EdgeInsets.all(15.0),
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 CachedNetworkImage(
    //                   imageUrl:
    //                       'https://images.unsplash.com/photo-1532264523420-881a47db012d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9', // Replace this with your image URL
    //                   placeholder: (context, url) =>
    //                       CircularProgressIndicator(),
    //                   errorWidget: (context, url, error) => Icon(Icons.error),
    //                   fit: BoxFit.cover,
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),

    //         Expanded(
    //           flex: 2,
    //           child: Container(
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(20.0),
    //               color: Colors.white,
    //               border: Border.all(
    //                 width: 2,
    //                 color: isSelected
    //                     ? Colors.green
    //                     : CustomColors.customLigthGray,
    //               ),
    //             ),
    //             padding: const EdgeInsets.all(25),
    //             margin: const EdgeInsets.all(1.5),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     offer.basePrice == offer.finalPrice
    //                         ? Row(
    //                             children: [
    //                               Text(
    //                                 offer.basePrice
    //                                     .toCurrency(currency, format),
    //                                 style: GoogleFonts.mulish(
    //                                   color: CustomColors.discountColor,
    //                                   fontWeight: FontWeight.w600,
    //                                   fontSize: 16.0,
    //                                   decoration: TextDecoration.lineThrough,
    //                                 ),
    //                               ),
    //                               const SizedBox(width: 8.0),
    //                               Text(
    //                                 '${discount.toStringAsFixed(0)}% ${SplashScreenNotifier.getLanguageLabel('OFF')}',
    //                                 style: GoogleFonts.mulish(
    //                                   color: CustomColors.discountPercentColor,
    //                                   fontWeight: FontWeight.w600,
    //                                   fontSize: 14.0,
    //                                 ),
    //                               ),
    //                             ],
    //                           )
    //                         : const Row(),
    //                     Text(
    //                       offer.finalPrice.toCurrency(currency, format),
    //                       style: GoogleFonts.mulish(
    //                         fontWeight: FontWeight.w800,
    //                         fontSize: 20.0,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 if (isSelected)
    //                   const Icon(
    //                     Icons.check_circle,
    //                     color: Colors.green,
    //                   )
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );

    return InkWell(
      onTap: onTap, //Dialogs.showCardInfo(context, offer),
      child: Stack(
        children: [
          Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 2,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: CustomColors.customLigthGray,
                      width: 1.5,
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  margin: const EdgeInsets.all(3.0),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(colors: colors),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        '$baseUrl/APP_PRODUCT_IMAGES_FOLDER/${offer.imageFileName?.trim()}',
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const ShimmerLoading(height: 100),
                    errorWidget: (_, __, ___) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MulishText(
                            text: offer.productName,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      MulishText(
                        text: offer.finalPrice.toCurrency(currency, format),
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                      ),
                    ],
                  ),
                  offer.basePrice == offer.finalPrice
                      ? Row(
                          children: [
                            MulishText(
                              text:
                                  offer.basePrice.toCurrency(currency, format),
                              fontColor: CustomColors.discountColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              textDecoration: TextDecoration.lineThrough,
                            ),
                            const SizedBox(width: 8.0),
                            MulishText(
                              text:
                                  '${discount.toStringAsFixed(0)}% ${SplashScreenNotifier.getLanguageLabel('OFF')}',
                              fontColor: CustomColors.discountPercentColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                          ],
                        )
                      : const Row()
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
