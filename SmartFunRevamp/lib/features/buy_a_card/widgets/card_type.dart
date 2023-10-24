import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/view/home_view.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

enum CardValue { silver, gold, platinum }

extension CardValueExtension on CardValue {
  String get name {
    switch (this) {
      case CardValue.silver:
        return SplashScreenNotifier.getLanguageLabel('SILVER');
      case CardValue.gold:
        return SplashScreenNotifier.getLanguageLabel('GOLD');
      case CardValue.platinum:
        return SplashScreenNotifier.getLanguageLabel('PLATINUM');
      default:
        return '';
    }
  }

  Gradient get colorGradient {
    switch (this) {
      case CardValue.silver:
        return CustomGradients.silverCircularGradient;
      case CardValue.gold:
        return CustomGradients.goldenCircularGradient;
      case CardValue.platinum:
        return CustomGradients.platimunGradient;
      default:
        return CustomGradients.disabledGradient;
    }
  }
}

List<Color> randomCard(CardsColor? cardColors) {
  int diceRoll = Random().nextInt(6) + 1;
  switch (diceRoll) {
    case 1:
      return cardColors?.silverGradient.getColorList() ?? [CustomColors.hardOrange, CustomColors.hardOrange];
    case 2:
      return cardColors?.silverGradient.getColorList() ?? [CustomColors.hardOrange, CustomColors.hardOrange];
    case 3:
      return cardColors?.goldGradient.getColorList() ?? [CustomColors.hardOrange, CustomColors.hardOrange];
    case 4:
      return cardColors?.goldGradient.getColorList() ?? [CustomColors.hardOrange, CustomColors.hardOrange];
    case 5:
      return cardColors?.platinumGradient.getColorList() ?? [CustomColors.hardOrange, CustomColors.hardOrange];
    case 6:
      return cardColors?.platinumGradient.getColorList() ?? [CustomColors.hardOrange, CustomColors.hardOrange];
    default:
      return cardColors?.silverGradient.getColorList() ?? [CustomColors.hardOrange, CustomColors.hardOrange];
  }
}

class CardType extends ConsumerWidget {
  const CardType({Key? key, required this.card}) : super(key: key);
  final CardProduct card;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parafaitDefault = ref.watch(parafaitDefaultsProvider);
    final currency = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencySymbol) ?? 'USD';
    final format = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencyFormat) ?? '#,##0.00';
    final cardColors = ref.watch(newHomePageCMSProvider)?.cardsColor;
    final colors = randomCard(cardColors);

    double discount = ((card.basePrice - card.finalPrice) * 100) / card.basePrice;
    final String baseUrl = Get.find<String>(tag: 'baseURL');
    return InkWell(
      onTap: () => Dialogs.showCardInfo(context, card),
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
                    imageUrl: '$baseUrl/APP_PRODUCT_IMAGES_FOLDER/${card.imageFileName?.trim()}',
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
                            text: card.productName,
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
                        text: card.finalPrice.toCurrency(currency, format),
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                      ),
                    ],
                  ),
                  card.basePrice == card.finalPrice
                      ? Row(
                          children: [
                            MulishText(
                              text: card.basePrice.toCurrency(currency, format),
                              fontColor: CustomColors.discountColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              textDecoration: TextDecoration.lineThrough,
                            ),
                            const SizedBox(width: 8.0),
                            MulishText(
                              text: '${discount.toStringAsFixed(0)}% ${SplashScreenNotifier.getLanguageLabel('OFF')}',
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
