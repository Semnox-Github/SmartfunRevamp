// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';

import 'package:semnox/core/domain/entities/card_details/card_details.dart';

import 'package:semnox/core/widgets/virtual_card_widget.dart';
import 'package:semnox/features/home/pages/home_page.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_bottom_sheet_button.dart';

class ViewVirtualCardPage extends ConsumerWidget {
  const ViewVirtualCardPage({
    Key? key,
    required this.cardDetails,
  }) : super(key: key);

  final CardDetails cardDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
              }),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/lost_card/check_ok.png',
                      height: 200.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Here is your virtual card',
                    style: TextStyle(
                      color: CustomColors.hardOrange,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: VirtualCardWidget(cardDetails: cardDetails),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 60.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'assets/lost_card/arrow_virtual_card.svg',
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
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
      ),
    );
  }
}
