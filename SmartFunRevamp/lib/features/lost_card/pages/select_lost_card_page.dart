import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/features/buy_a_card/pages/estimated_transaction_page.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_bottom_sheet_button.dart';
import 'package:semnox/features/recharge_card/widgets/site_dropdown.dart';
import 'package:semnox/features/recharge_card/widgets/user_cards.dart';

import 'lost_card_page.dart';

class SelectCardLostPage extends StatefulWidget {
  const SelectCardLostPage({Key? key}) : super(key: key);

  @override
  State<SelectCardLostPage> createState() => _SelectCardLostPageState();
}

class _SelectCardLostPageState extends State<SelectCardLostPage> {
  String selectedCardNumber = '';
  @override
  Widget build(BuildContext context) {
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
      bottomSheet: BottomSheetButton(
        label: 'BLOCK & ISSUE REPLACEMENT',
        onTap: () => {
          Navigator.pop(context),
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LostCardPage(cardNumber: selectedCardNumber),
            ),
          ),
        }
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SitesAppBarDropdown(),
            UserCards(
              onCardSelected: (card) {
                selectedCardNumber = card;
              },
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    const SizedBox(height: 20.0),
                    const Text(
                      'Lost Card Terms',
                      style: TextStyle(
                        color: CustomColors.hardOrange,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'This Card cannot be used for any further transactions. A temporary will be issued, exachange the temporary card for a new physical carrd at site',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                        color: CustomColors.customBlack,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    Text(
                      '40 need to paid while exchanging for a new physical card',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                        color: CustomColors.customBlack,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
