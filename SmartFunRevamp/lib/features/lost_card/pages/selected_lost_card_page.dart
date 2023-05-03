import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/widgets/card_widget.dart';
import 'package:semnox/features/lost_card/widgets/block_card_button.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class SelectedCardLostPage extends StatelessWidget {
  const SelectedCardLostPage({Key? key, required this.cardDetails}) : super(key: key);

  final CardDetails cardDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFF8FF),
        elevation: 0.0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          SplashScreenNotifier.getLanguageLabel('Lost Card'),
          style: const TextStyle(
            color: CustomColors.customBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomSheet: BlockCardButton(cardDetails: cardDetails),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              margin: const EdgeInsets.only(bottom: 10.0),
              decoration: const BoxDecoration(
                color: CustomColors.customLigthBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: CardWidget(cardDetails: cardDetails),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                  const SizedBox(height: 20.0),
                  Text(
                    SplashScreenNotifier.getLanguageLabel('Lost Card Terms'),
                    style: const TextStyle(
                      color: CustomColors.hardOrange,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    SplashScreenNotifier.getLanguageLabel('This Card cannot be used for any further transactions. A temporary will be issued, exachange the temporary card for a new physical carrd at site'),
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
                    SplashScreenNotifier.getLanguageLabel('40 need to paid while exchanging for a new physical card'),
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
