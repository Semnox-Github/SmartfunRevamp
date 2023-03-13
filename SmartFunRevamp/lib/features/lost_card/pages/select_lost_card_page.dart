import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_bottom_sheet_button.dart';
import 'package:semnox/features/recharge_card/widgets/user_cards.dart';

import 'lost_card_page.dart';

class SelectCardLostPage extends ConsumerWidget {
  const SelectCardLostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CardDetails? selectedCardNumber;
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
      // bottomSheet: BlockCardButton(cardDetails: selectedCardNumber),
      bottomSheet: BottomSheetButton(
          label: 'BLOCK & ISSUE REPLACEMENT',
          onTap: () {
            if (selectedCardNumber!.accountNumber!.startsWith('T')) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.infoReverse,
                animType: AnimType.scale,
                title: 'Lost Card',
                desc: 'Your card ${selectedCardNumber!.accountNumber} has been blocked.',
                btnOkOnPress: () {},
              ).show();
            } else {
              ref.listenManual(
                CardsProviders.lostCardProvider(selectedCardNumber!),
                (previous, next) {
                  next.maybeWhen(
                    orElse: () => {},
                    data: (data) {
                      ref.invalidate(CardsProviders.userCardsProvider);
                      ref.read(CardsProviders.userCardsProvider);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LostCardPage(cardDetails: selectedCardNumber!),
                        ),
                      );
                    },
                    error: (e, s) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.scale,
                        title: 'Lost Card',
                        desc: 'Sorry, we have had a problem. Please contact our Staff',
                        btnOkOnPress: () {},
                      ).show();
                    },
                  );
                },
              );
            }
          }),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.33,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              margin: const EdgeInsets.only(bottom: 10.0),
              decoration: const BoxDecoration(
                color: CustomColors.customLigthBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: UserCards(
                onCardSelected: (card) {
                  selectedCardNumber = card;
                },
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
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
                  const SizedBox(height: 20.0),
                  const Divider(
                    color: CustomColors.customLigthBlack,
                    thickness: 0.5,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    '40 need to paid while exchanging for a new physical card',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                      color: CustomColors.customBlack,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Divider(
                    color: CustomColors.customLigthBlack,
                    thickness: 0.5,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
