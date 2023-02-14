import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/features/payment/pages/payment_options_page.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/features/buy_a_card/provider/estimate/estimate_provider.dart';
import 'package:semnox/features/buy_a_card/widgets/bill_detail_row.dart';
import 'package:semnox/features/buy_a_card/widgets/coupon_container.dart';

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
                            BillDetailRow(
                              description: 'Recharge Amount',
                              amount: '${transactionResponse.transactionAmount}',
                            ),
                            BillDetailRow(
                              description: 'Tax',
                              amount: '${transactionResponse.taxAmount}',
                            ),
                            BillDetailRow(
                              description: 'Discount (Offer)',
                              amount: '${transactionResponse.transactionDiscountAmount}',
                            ),
                            if (transactionResponse.couponDiscountAmount != null)
                              BillDetailRow(
                                description: 'Discount (Coupon)',
                                amount: '${transactionResponse.couponDiscountAmount}',
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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentOptionsPage(
                                      transactionResponse: transactionResponse,
                                      cardProduct: cardProduct,
                                    ),
                                  ),
                                );
                              },
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
