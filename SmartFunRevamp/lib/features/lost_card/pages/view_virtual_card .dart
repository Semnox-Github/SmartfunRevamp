import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/features/home/pages/home_page.dart';
import 'package:semnox/features/payment/pages/payment_options_page.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/features/buy_a_card/provider/estimate/estimate_provider.dart';
import 'package:semnox/features/buy_a_card/widgets/bill_detail_row.dart';
import 'package:semnox/features/buy_a_card/widgets/coupon_container.dart';

import '../../recharge_card/widgets/recharge_bottom_sheet_button.dart';

class ViewVirtualCardPage extends ConsumerWidget {
  const ViewVirtualCardPage({
    Key? key,
    this.cardNumber,
  }) : super(key: key);

  final String? cardNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      /*
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
      */
      bottomSheet: BottomSheetButton(
        label: 'OKAY,  GOT IT',
        onTap: () => {
          Navigator.pop(context),
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          ),
        }
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: 
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/select_location/select_location_img.png',
                      height: 200.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    'Here is your virtual card',
                     style: TextStyle(
                        color: CustomColors.hardOrange,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                  const SizedBox(height: 30.0),
                  Image.asset('assets/home/carousel_test.png'),
                  const SizedBox(height: 30.0),
                  Text(
                    'Show this Barcode on site to get a new physical card. A payment of 40 will be charged for the replacement on site.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                      color: CustomColors.customBlack,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ), 
      ),
    );
  }
}
