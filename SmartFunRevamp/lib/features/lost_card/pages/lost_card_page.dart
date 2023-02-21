import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/features/payment/pages/payment_options_page.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/features/buy_a_card/provider/estimate/estimate_provider.dart';
import 'package:semnox/features/buy_a_card/widgets/bill_detail_row.dart';
import 'package:semnox/features/buy_a_card/widgets/coupon_container.dart';

class LostCardPage extends ConsumerWidget {
  const LostCardPage({
    Key? key,
    this.cardNumber,
  }) : super(key: key);

  final String? cardNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*
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
    */
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFF8FF),
        elevation: 0.0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Lost Card',
          style: TextStyle(
            color: CustomColors.customBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: 
          Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/select_location/select_location_img.png',
                  height: 200.0,
                ),
              ),
              const SizedBox(width: 5.0),
              Text(
                // offer.credits.toStringAsFixed(0),
                'Lost Card',
                style: GoogleFonts.mulish(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ],
          ), 
      ),
    );
  }
}
