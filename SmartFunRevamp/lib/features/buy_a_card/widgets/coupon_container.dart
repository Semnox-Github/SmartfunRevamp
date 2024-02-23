import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/buy_a_card/provider/estimate/estimate_provider.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class CouponContainer extends ConsumerWidget {
  const CouponContainer(
      this.cardProduct, this.estimated, this.qty, this.transactionType,
      {Key? key})
      : super(key: key);
  final CardProduct cardProduct;
  final EstimateTransactionResponse estimated;
  final int qty;
  final String transactionType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.customLigthGray),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MulishText(
            text: SplashScreenNotifier.getLanguageLabel('Coupons'),
            // style: const TextStyle(
            // color: Colors.black,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.justify,
            //),
          ),
          InkWell(
            onTap: () => Dialogs.getCoupongNumberDialog(
                context,
                ref,
                cardProduct,
                transactionType == "newcard" ? null : estimated.primaryCard,
                qty),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE9DC),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.percent,
                    color: CustomColors.hardOrange,
                    size: 14.0,
                  ),
                  const SizedBox(width: 5.0),
                  estimated.couponDiscountAmount == null
                      ? Text(
                          SplashScreenNotifier.getLanguageLabel(
                              'Add coupons and save more'),
                          style: const TextStyle(
                            color: CustomColors.hardOrange,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      : Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MulishText(
                                text:
                                    '${estimated.couponNumber}(${estimated.couponDiscountAmount?.toInt()}%)',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                fontColor: CustomColors.hardOrange,
                              ),
                              TextButton(
                                onPressed: () => ref
                                    .read(estimateStateProvider.notifier)
                                    .resetCoupon(),
                                style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                    (states) => CustomColors.customOrange,
                                  ),
                                ),
                                child: const MulishText(
                                  text: 'REMOVE',
                                  fontColor: CustomColors.hardOrange,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
