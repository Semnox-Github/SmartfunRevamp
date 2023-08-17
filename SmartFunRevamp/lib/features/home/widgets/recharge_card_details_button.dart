import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/features/cards_detail/card_detail_page.dart';
import 'package:semnox/features/splash/cms_provider.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class RechargeCardDetailsButton extends ConsumerWidget {
  RechargeCardDetailsButton({
    Key? key,
    required this.cardDetails,
  }) : super(key: key);
  late final CardDetails cardDetails;
  late final DateTime timeNow = DateTime.now();
  late final DateTime expirationDate = cardDetails.expiryDate != null ? DateTime.parse(cardDetails.expiryDate.toString()) : timeNow;
  late final int daysUntilExpiration = (expirationDate.difference(timeNow).inHours / 24).round();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = ref.watch(cmsProvider).value?.routes;
    if (daysUntilExpiration < 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
        ],
      );
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
                    onPressed: () => Navigator.pushNamed(context, routes?.rechargePage ?? Routes.kRechargePageCard),
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
                SplashScreenNotifier.getLanguageLabel('This card can not be used for any further transactions. Exchange virtual card for a new physical card at site.'),
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
