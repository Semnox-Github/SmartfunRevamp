import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/general_error_widget.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/buy_a_card/provider/estimate/estimate_provider.dart';
import 'package:semnox/features/buy_a_card/widgets/bill_detail_row.dart';
import 'package:semnox/features/buy_a_card/widgets/coupon_container.dart';
import 'package:semnox/features/payment/pages/payment_options_page.dart';
import 'package:semnox/features/recharge_card/providers/products_price_provider.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

import '../../../core/widgets/custom_app_bar.dart';

final currentTransactionIdProvider = StateProvider<int?>((ref) {
  return null;
});

class EstimatedTransactionPage extends ConsumerStatefulWidget {
  const EstimatedTransactionPage(
      {Key? key,
      required this.cardProduct,
      this.cardSelected,
      required this.transactionType,
      required this.qty,
      this.finalPrice})
      : super(key: key);

  final CardProduct cardProduct;
  final CardDetails? cardSelected;
  final String transactionType;
  final int qty;
  final double? finalPrice;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      EstimatedTransactionPageState();
  // _MyAppState createState() => _MyAppState();
}

class EstimatedTransactionPageState
    extends ConsumerState<EstimatedTransactionPage> {
  bool showAlert = false;
  String message = '';

  void showErrorDialog(BuildContext context, message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /* Ver card number acount Numbre*/

    final siteId = ref.watch(selectedSiteIdProvider);
    ref.read(estimateStateProvider.notifier).getEstimateTransaction(
        widget.cardProduct,
        cardNumber: widget.cardSelected != null
            ? widget.cardSelected!.accountNumber
            : '',
        quantity: widget.qty,
        siteId: siteId,
        finalPrice: widget.finalPrice!);
    ref.listen(estimateStateProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => {},
        transactionEstimated: (estimated) {
          if (estimated.couponDiscountAmount != null) {
            Dialogs.couponSuccessDialog(
                context, estimated.transactionDiscountAmount, ref);
          }
          ref
              .read(currentTransactionIdProvider.notifier)
              .update((_) => estimated.transactionId);
        },
        error: (message) {
          showErrorDialog(context, message);
        },
        // invalidCoupon: (message) {
        //   AwesomeDialog(
        //     context: context,
        //     dialogType: DialogType.error,
        //     animType: AnimType.scale,
        //     title: SplashScreenNotifier.getLanguageLabel('Error'),
        //     desc: message,
        //     btnOkOnPress: () => {},
        //   ).show();
        // },
      );
    });

    // if (showAlert && mounted) {
    //   showErrorDialog(context);
    // }
    final cmsBody = ref.watch(cmsBodyStyleProvider);
    final parafaitDefault = ref.watch(parafaitDefaultsProvider);
    final areDiscountsEnabled =
        parafaitDefault?.getDefault(ParafaitDefaultsResponse.enableDiscounts) ==
            'Y';
    final currency =
        parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencySymbol) ??
            'USD';
    final format =
        parafaitDefault?.getDefault(ParafaitDefaultsResponse.currencyFormat) ??
            '#,##0.00';

    return Scaffold(
      backgroundColor: HexColor.fromHex(cmsBody?.appBackGroundColor),
      appBar: CustomAppBar(
        title: SplashScreenNotifier.getLanguageLabel(
          widget.transactionType == "newcard" ? "Buy a Card" : "Recharge",
        ),
      ),
      // AppBar(
      //   title: Text(
      //     SplashScreenNotifier.getLanguageLabel(
      //       transactionType == "newcard" ? "Buy a Card" : "Recharge",
      //     ),
      //     style: const TextStyle(
      //       color: CustomColors.customBlue,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Consumer(
          builder: (context, ref, child) {
            return ref.watch(estimateStateProvider).maybeWhen(
                  orElse: () => Container(),
                  //error: (message) => GeneralErrorWidget(message: message),
                  inProgress: () =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                  transactionEstimated: (transactionResponse) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MulishText(
                          text: SplashScreenNotifier.getLanguageLabel('Value'),
                          // style: const TextStyle(
                          //color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        // ),
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
                                widget.cardProduct.productName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.cardProduct.productType == "VARIABLECARD"
                                    ? widget.finalPrice
                                        .toCurrency(currency, format)
                                    : (widget.cardProduct.finalPrice *
                                            widget.qty)
                                        .toCurrency(currency, format),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (areDiscountsEnabled)
                          CouponContainer(
                              widget.cardProduct,
                              transactionResponse,
                              widget.qty,
                              widget.transactionType)
                        else
                          const SizedBox(
                            height: 20,
                          ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MulishText(
                              text: SplashScreenNotifier.getLanguageLabel(
                                  'Bills Details'),
                              // style: const TextStyle(
                              //color: Colors.black,
                              fontWeight: FontWeight.bold,
                              //),
                            ),
                            BillDetailRow(
                              description:
                                  SplashScreenNotifier.getLanguageLabel(
                                      'Amount'),
                              amount: transactionResponse.transactionAmount
                                  .toCurrency(currency, format),
                            ),
                            BillDetailRow(
                              description:
                                  SplashScreenNotifier.getLanguageLabel('Tax'),
                              amount: transactionResponse.taxAmount
                                  .toCurrency(currency, format),
                            ),
                            BillDetailRow(
                              description:
                                  SplashScreenNotifier.getLanguageLabel(
                                      'Discount (Offer)'),
                              amount: transactionResponse
                                  .transactionDiscountAmount
                                  .toCurrency(currency, format),
                            ),
                            if (transactionResponse.couponDiscountAmount !=
                                null)
                              BillDetailRow(
                                description:
                                    SplashScreenNotifier.getLanguageLabel(
                                        'Discount (Coupon)'),
                                amount: transactionResponse.couponDiscountAmount
                                    .toCurrency(currency, format),
                              ),
                            const Divider(
                              color: CustomColors.customLigthBlue,
                              thickness: 1.5,
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MulishText(
                                  text: SplashScreenNotifier.getLanguageLabel(
                                      'Payable Amount'),
                                  // style: const TextStyle(
                                  // color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  //),
                                ),
                                MulishText(
                                  text: transactionResponse.transactionNetAmount
                                      .toCurrency(currency, format),
                                  // style: const TextStyle(
                                  // color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  // ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MulishText(
                              text: transactionResponse.transactionNetAmount
                                  .toCurrency(currency, format),
                              // style: const TextStyle(
                              //   color: Colors.black,
                              fontWeight: FontWeight.bold,
                              //),
                            ),
                            PrimaryButton(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentOptionsPage(
                                      transactionResponse: transactionResponse,
                                      cardProduct: widget.cardProduct,
                                      cardDetails: widget.cardSelected,
                                      transactionType: widget.transactionType,
                                      finalPrice: widget.finalPrice,
                                    ),
                                  ),
                                );
                              },
                              label: SplashScreenNotifier.getLanguageLabel(
                                  'PROCEED TO PAY'),
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
