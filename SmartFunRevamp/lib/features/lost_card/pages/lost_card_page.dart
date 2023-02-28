import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/features/lost_card/pages/view_virtual_card%20.dart';
import 'package:semnox/features/payment/pages/payment_options_page.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/features/buy_a_card/provider/estimate/estimate_provider.dart';
import 'package:semnox/features/buy_a_card/widgets/bill_detail_row.dart';
import 'package:semnox/features/buy_a_card/widgets/coupon_container.dart';

import '../../recharge_card/widgets/recharge_bottom_sheet_button.dart';

class LostCardPage extends ConsumerWidget {
  const LostCardPage({
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
        label: 'VIEW VIRTUAL CARD',
        onTap: () => {
          Navigator.pop(context),
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ViewVirtualCardPage(),
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
                    'Card  Sucessfully Blocked',
                     style: TextStyle(
                        color: CustomColors.hardOrange,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'You card  $cardNumber has been blocked and you no longer will be abe to use it.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                      color: CustomColors.customBlack,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Stack(
                children: [
                  BlurryContainer(
                    color: Colors.white.withOpacity(0.15),
                    blur: 10,
                    elevation: 6,
                    height: 200,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/home/carousel_test.png', 
                        ),
                      ],
                    ),
                  ),
                   
                ] 
              ),
              const SizedBox(height: 30.0),
              Text(
                'We have transfered all your credits and other points to a new virtual card.',
                textAlign: TextAlign.center,
                style: GoogleFonts.mulish(
                  color: CustomColors.customBlack,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ), 
      ),
    );
  }
}
