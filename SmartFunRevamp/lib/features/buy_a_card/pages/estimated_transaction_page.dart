import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/buy_a_card/provider/estimate/estimate_provider.dart';

class EstimatedTransactionPage extends ConsumerWidget {
  const EstimatedTransactionPage({
    Key? key,
    required this.cardProduct,
    this.cardNumber,
  }) : super(key: key);

  final CardProduct cardProduct;
  final String? cardNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(estimateStateProvider.notifier).getEstimateTransaction(cardProduct, cardNumber: cardNumber);
    ref.listen(estimateStateProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => {},
        transactionEstimated: (estimated) {
          if (estimated.couponDiscountAmount != null) {
            Dialogs.couponSuccessDialog(context, estimated.transactionDiscountAmount);
          }
        },
        invalidCoupon: (message) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: 'Error',
            desc: message,
            btnOkOnPress: () => {},
          ).show();
        },
      );
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFF8FF),
        elevation: 0.0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Recharge',
          style: TextStyle(
            color: CustomColors.customBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Consumer(
          builder: (context, ref, child) {
            return ref.watch(estimateStateProvider).maybeWhen(
                  orElse: () => Container(),
                  inProgress: () => const Center(child: CircularProgressIndicator()),
                  transactionEstimated: (transactionResponse) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recharge Value',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEEB2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${cardProduct.credits} play credit',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${cardProduct.finalPrice}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CouponContainer(cardProduct, transactionResponse),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Bills Details',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Recharge Amount'),
                                Text('\$${transactionResponse.transactionAmount}'),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Tax'),
                                Text('\$${transactionResponse.taxAmount}'),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Discount (Offer)'),
                                Text('-\$${transactionResponse.transactionDiscountAmount}'),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            if (transactionResponse.couponDiscountAmount != null)
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Discount (Coupon)'),
                                    Text('-\$${transactionResponse.couponDiscountAmount}'),
                                  ],
                                ),
                              ),
                            const Divider(
                              color: CustomColors.customLigthBlue,
                              thickness: 1.5,
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Payable Amount',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$ ${transactionResponse.transactionAmount}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$ ${transactionResponse.transactionAmount}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'View Details',
                                  style: TextStyle(
                                    color: CustomColors.hardOrange,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                            CustomButton(
                              onTap: () {},
                              label: 'PROCEED TO PAY',
                              width: 200,
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}

class CouponContainer extends ConsumerWidget {
  const CouponContainer(this.cardProduct, this.estimated, {Key? key}) : super(key: key);
  final CardProduct cardProduct;
  final EstimateTransactionResponse estimated;

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
          const Text(
            'Coupons',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () => Dialogs.getCoupongNumberDialog(context, ref, cardProduct),
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
                      ? const Text(
                          'Add coupons and save more',
                          style: TextStyle(
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
                                text: '${estimated.couponNumber}(${estimated.couponDiscountAmount?.toInt()}%)',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                fontColor: CustomColors.hardOrange,
                              ),
                              TextButton(
                                onPressed: () => ref.read(estimateStateProvider.notifier).resetCoupon(),
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
