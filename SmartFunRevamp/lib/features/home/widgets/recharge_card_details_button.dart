import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/features/cards_detail/card_detail_page.dart';
import 'package:semnox/features/recharge_card/pages/select_recharge_card_page.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class RechargeCardDetailsButton extends StatelessWidget {
  RechargeCardDetailsButton({
    Key? key,
    required this.cardDetails,
  }) : super(key: key);
  late final CardDetails cardDetails;
  late final DateTime timeNow = DateTime.now();
  late final DateTime expirationDate = cardDetails.expiryDate != null ? DateTime.parse(cardDetails.expiryDate.toString()) : timeNow;
  late final int daysUntilExpiration = (expirationDate.difference(timeNow).inHours / 24).round();

  @override
  Widget build(BuildContext context) {
    if (daysUntilExpiration < 0) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Expanded(
          child: Column(
            children: [
              Text(
                '${SplashScreenNotifier.getLanguageLabel('This card has expired on')} ${DateFormat('dd MMM yyyy').format(expirationDate)}\n',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
              Text(
                SplashScreenNotifier.getLanguageLabel('You will no longer be able to use this card. But you can still view the Gameplay history and Activity details.'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ]);
    } else if (!cardDetails.accountNumber!.startsWith('T')) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: CustomGradients.linearGradient,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    gradient: CustomGradients.linearGradient,
                  ),
                  margin: const EdgeInsets.all(3),
                  child: TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectCardRechargePage(cardDetails: cardDetails),
                      ),
                    ),
                    child: Text(
                      SplashScreenNotifier.getLanguageLabel('RECHARGE NOW'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: CustomGradients.linearGradient,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.all(3),
                  child: TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardDetailPage(cardDetails: cardDetails),
                      ),
                    ),
                    child: Text(
                      SplashScreenNotifier.getLanguageLabel('CARD DETAILS'),
                      style: const TextStyle(
                        color: CustomColors.hardOrange,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Expanded(
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       gradient: CustomGradients.linearGradient,
                  //       borderRadius: BorderRadius.circular(15.0),
                  //     ),
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(12.0),
                  //         gradient: CustomGradients.linearGradient,
                  //       ),
                  //       margin: const EdgeInsets.all(3),
                  //       child: TextButton(
                  //         onPressed: () => Navigator.pushNamed(context, Routes.kRechargePageCard),
                  //         child: const Text(
                  //           'RECHARGE NOW',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(width: 20.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: CustomGradients.linearGradient,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.all(3),
                        child: TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CardDetailPage(cardDetails: cardDetails),
                            ),
                          ),
                          child: Text(
                            SplashScreenNotifier.getLanguageLabel('CARD DETAILS'),
                            style: const TextStyle(
                              color: CustomColors.hardOrange,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3.0),
              Text(
                SplashScreenNotifier.getLanguageLabel('Your card &1 has been blocked, based on your request. You no longer will be to use it.').replaceAll('&1', cardDetails.accountNumber.toString()),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 8,
                ),
              ),
              Text(
                ' ${SplashScreenNotifier.getLanguageLabel('This card will be removed from smartfun once you get the new physical card.')}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ),
      ]);
    }
  }
}
