import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/discount_entity.dart';
import 'package:semnox/core/widgets/recharge_card_widget.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/buy_a_card/pages/estimated_transaction_page.dart';
import 'package:semnox/features/buy_a_card/provider/estimate/estimate_provider.dart';

class Dialogs {
  static void couponSuccessDialog(BuildContext context, double couponValue) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      title: 'Error',
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MulishText(
                  text: '\$$couponValue',
                  fontSize: 48.0,
                ),
                Image.asset(
                  'assets/buy_card/coupon_congrats.png',
                  height: 80.0,
                )
              ],
            ),
            const MulishText(
              text: 'Saved on the bill with the coupon',
              fontColor: CustomColors.couponTextColor,
            )
          ],
        ),
      ),
    ).show();
  }

  static void getCoupongNumberDialog(BuildContext context, WidgetRef ref, CardProduct cardProduct) {
    final key = GlobalKey<FormState>();
    String coupon = '';
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      body: Form(
        key: key,
        child: TextFormField(
          validator: (value) => value!.isNotEmpty ? null : 'Required',
          onSaved: (newValue) => coupon = newValue!,
          decoration: const InputDecoration(
            hintText: 'Coupon',
          ),
        ),
      ),
      btnOkOnPress: () {
        if (key.currentState!.validate()) {
          key.currentState!.save();
          ref.read(estimateStateProvider.notifier).getEstimateTransaction(
                cardProduct,
                dtoList: DiscountApplicationHistoryDTOList(-1, coupon, -1),
              );
        }
      },
    ).show();
  }

  static void showCardInfo(BuildContext context, CardProduct card) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: CustomColors.customLigthBlue,
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          card.productName,
                          style: GoogleFonts.mulish(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.cancel_outlined,
                          ),
                        )
                      ],
                    ),
                  ),
                  RechargeCardWidget(cardProduct: card),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Features & Terms',
                          style: GoogleFonts.mulish(
                            fontWeight: FontWeight.w800,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          '\u2022 Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                          style: GoogleFonts.mulish(
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          '\u2022 Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                          style: GoogleFonts.mulish(
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          '\u2022 Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                          style: GoogleFonts.mulish(
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          '\u2022 Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                          style: GoogleFonts.mulish(
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        CustomButton(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EstimatedTransactionPage(cardProduct: card),
                              ),
                            );
                          },
                          label: 'BUY NOW @ ${card.finalPrice.toStringAsFixed(0)}',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showMessageInfo(BuildContext context, String title, String meessge) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.infoReverse,
      animType: AnimType.scale,
      title: title,
      desc: meessge,
      descTextStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      btnOkOnPress: () {},
      btnOkText: 'OK',
      btnOkColor: Colors.blue,
    ).show();
  }
}
