// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';

import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/image_handler.dart';

import 'package:semnox/core/widgets/virtual_card_widget.dart';
import 'package:semnox/features/home/view/home_view.dart';
import 'package:semnox/features/recharge_card/widgets/recharge_bottom_sheet_button.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

import '../../../core/widgets/mulish_text.dart';
import '../../splash/provider/new_splash_screen/new_splash_screen_notifier.dart';

class ViewVirtualCardPage extends ConsumerWidget {
  const ViewVirtualCardPage({
    Key? key,
    required this.cardDetails,
  }) : super(key: key);

  final CardDetails cardDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardColors = ref.watch(newHomePageCMSProvider)?.cardsColor;
    final cmsBody = ref.watch(cmsBodyStyleProvider);

    return Scaffold(
      backgroundColor: HexColor.fromHex(cmsBody?.appBackGroundColor),
      bottomSheet: BottomSheetButton(
          color: HexColor.fromHex(cmsBody?.appBackGroundColor),
          label: SplashScreenNotifier.getLanguageLabel('OKAY,  GOT IT'),
          onTap: () => {
                Navigator.pop(context),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeView(),
                  ),
                ),
              }),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ImageHandler(
                      height: 200.0,
                      imageKey: "check_ok_image_path",
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    SplashScreenNotifier.getLanguageLabel(
                        'Here is your virtual card'),
                    style: TextStyle(
                      color: CustomColors.hardOrange,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: VirtualCardWidget(
                        cardDetails: cardDetails,
                        cardColor: HexColor.fromHex(cardColors?.virtual)),
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
                  MulishText(
                    text: SplashScreenNotifier.getLanguageLabel(
                        'Show this Barcode on site to get a new physical card. A payment of 40 will be charged for the replacement on site.'),
                    textAlign: TextAlign.center,
                    // style: GoogleFonts.mulish(
                    //   color: CustomColors.customBlack,
                    //fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                    // ),
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
