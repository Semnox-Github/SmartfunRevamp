import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/widgets/blocked_card_widget.dart';
import 'package:semnox/features/lost_card/pages/view_virtual_card%20.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';


import '../../recharge_card/widgets/recharge_bottom_sheet_button.dart';

class LostCardPage extends ConsumerWidget {
  const LostCardPage({
    Key? key,
    required this.cardDetails,
  }) : super(key: key);

  final CardDetails cardDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomSheet: BottomSheetButton(
        label: SplashScreenNotifier.getLanguageLabel('VIEW VIRTUAL CARD'),
        onTap: () => {
          Navigator.pop(context),
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewVirtualCardPage(cardDetails: cardDetails),
            ),
          ),
        }
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: 
          Padding(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20.0),
                    Text(
                      SplashScreenNotifier.getLanguageLabel('Card  Sucessfully Blocked'),
                       style: const TextStyle(
                          color: CustomColors.hardOrange,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      SplashScreenNotifier.getLanguageLabel('You card  &1 has been blocked and you no longer will be abe to use it.').replaceAll("&1", cardDetails.accountNumber.toString()),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                        color: CustomColors.customBlack,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),      
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: BlockedCardWidget(cardDetails: cardDetails), 
                ),
                Text(
                  SplashScreenNotifier.getLanguageLabel('We have transfered all your credits and other points to a new virtual card.'),
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
      ),
    );
  }
}
