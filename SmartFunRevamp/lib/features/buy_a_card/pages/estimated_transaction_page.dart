import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/features/buy_a_card/provider/estimate/estimate_provider.dart';
import 'package:semnox/features/buy_a_card/widgets/bill_detail_row.dart';
import 'package:semnox/features/buy_a_card/widgets/coupon_container.dart';
import 'package:semnox/features/payment/pages/payment_options_page.dart';
import 'package:semnox/features/splash/after_splash_screen.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class EstimatedTransactionPage extends ConsumerWidget {
  const EstimatedTransactionPage({Key? key, required this.cardProduct, this.cardSelected, required this.transactionType, required this.qty, this.finalPrice}) : super(key: key);

  final CardProduct cardProduct;
  final CardDetails? cardSelected;
  final String transactionType;
  final int qty;
  final double? finalPrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /* Ver card number acount Numbre*/
    final siteId = ref.read(loginProvider.notifier).selectedSite?.siteId ?? Get.find<ExecutionContextDTO>().siteId;
    ref
        .read(estimateStateProvider.notifier)
        .getEstimateTransaction(cardProduct, cardNumber: cardSelected != null ? cardSelected!.accountNumber : '', quantity: qty, siteId: siteId!, finalPrice: finalPrice!);
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
            title: SplashScreenNotifier.getLanguageLabel('Error'),
            desc: message,
            btnOkOnPress: () => {},
          ).show();
        },
      );
    });
    final parafaitDefault = ref.watch(parafaitDefaultsProvider).value;
    final currency = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencySymbol) ?? 'USD';
    final format = parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencyFormat) ?? '#,##0.00';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFF8FF),
        elevation: 0.0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          SplashScreenNotifier.getLanguageLabel(
            transactionType == "newcard" ? "Buy a Card" : "Recharge",
          ),
          style: const TextStyle(
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
                        Text(
                          SplashScreenNotifier.getLanguageLabel('Recharge Value'),
                          style: const TextStyle(
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
                                cardProduct.productName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                cardProduct.productType == "VARIABLECARD" ? finalPrice.toCurrency(currency, format) : (cardProduct.finalPrice * qty).toCurrency(currency, format),
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
                            Text(
                              SplashScreenNotifier.getLanguageLabel('Bills Details'),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            BillDetailRow(
                              description: SplashScreenNotifier.getLanguageLabel('Recharge Amount'),
                              amount: transactionResponse.transactionAmount.toCurrency(currency, format),
                            ),
                            BillDetailRow(
                              description: SplashScreenNotifier.getLanguageLabel('Tax'),
                              amount: transactionResponse.taxAmount.toCurrency(currency, format),
                            ),
                            BillDetailRow(
                              description: SplashScreenNotifier.getLanguageLabel('Discount (Offer)'),
                              amount: transactionResponse.transactionDiscountAmount.toCurrency(currency, format),
                            ),
                            if (transactionResponse.couponDiscountAmount != null)
                              BillDetailRow(
                                description: SplashScreenNotifier.getLanguageLabel('Discount (Coupon)'),
                                amount: transactionResponse.couponDiscountAmount.toCurrency(currency, format),
                              ),
                            const Divider(
                              color: CustomColors.customLigthBlue,
                              thickness: 1.5,
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  SplashScreenNotifier.getLanguageLabel('Payable Amount'),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  transactionResponse.transactionNetAmount.toCurrency(currency, format),
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
                            Text(
                              transactionResponse.transactionNetAmount.toCurrency(currency, format),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CustomButton(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentOptionsPage(
                                      transactionResponse: transactionResponse,
                                      cardProduct: cardProduct,
                                      cardDetails: cardSelected,
                                      transactionType: transactionType,
                                      finalPrice: finalPrice,
                                    ),
                                  ),
                                );
                              },
                              label: SplashScreenNotifier.getLanguageLabel('PROCEED TO PAY'),
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
