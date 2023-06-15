import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/background_card_details.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({Key? key, this.cardNumber, required this.amount, required this.transactionType}) : super(key: key);
  final String? cardNumber;
  final double amount;
  final String transactionType;
  @override
  Widget build(BuildContext context) {
    final String fixedAmount = amount.toStringAsFixed(2);
    final DateTime dateToday = DateTime.now();
    final DateTime dateOneYearLater = DateTime(dateToday.year + 1, dateToday.month, dateToday.day);
    if (transactionType == "newcard") {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/payment/recharge_successful.png',
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              const SizedBox(height: 10.0),
              const MulishText(
                textAlign: TextAlign.center,
                text: 'Payment Successful',
                fontColor: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              const MulishText(
                textAlign: TextAlign.center,
                text: 'Your new card has been added to your account',
                fontColor: Colors.black45,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              const SizedBox(height: 10.0),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BackgroundCard(
                    isVirtual: false,
                    isExpired: false,
                    cardNumber: cardNumber!,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '$cardNumber',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 7.0),
                                Text(
                                  SplashScreenNotifier.getLanguageLabel('+Add nickname'),
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => Dialogs.showBarcodeTempCard(context, cardNumber!),
                              child: Image.asset(
                                'assets/home/QR.png',
                                height: 42.0,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          '${DateFormat('dd  MMM yyyy').format(dateToday)} ${DateFormat('- dd  MMM yyyy').format(dateOneYearLater)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            Image.asset(
                              'assets/payment/coin.png',
                              scale: 0.8,
                            ),
                            Text(
                              '  \$ $fixedAmount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${DateFormat('dd  MMM yyyy').format(dateToday)} ${DateFormat('- dd  MMM yyyy').format(dateOneYearLater)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const MulishText(
                textAlign: TextAlign.center,
                text: 'Convert your virtual card to a Physical Card',
                fontColor: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 29,
              ),
              const MulishText(
                textAlign: TextAlign.center,
                text: 'Instructions - Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt u - ',
                fontColor: Colors.black45,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )
            ],
          ),
        ),
        bottomSheet: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            gradient: CustomGradients.linearGradient,
          ),
          margin: const EdgeInsets.all(3),
          child: TextButton(
            onPressed: () {
              Dialogs.showTransactionFeedbackDialog(
                context,
                () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              );
            },
            child: const Text(
              'BACK TO HOME',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/payment/recharge_successful.png',
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              const SizedBox(height: 10.0),
              const MulishText(
                textAlign: TextAlign.center,
                text: 'Recharge Successful',
                fontColor: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              MulishText(
                textAlign: TextAlign.center,
                text: 'You have successfully recharged \$$fixedAmount on to your $cardNumber',
                fontColor: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )
            ],
          ),
        ),
        bottomSheet: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            gradient: CustomGradients.linearGradient,
          ),
          margin: const EdgeInsets.all(3),
          child: TextButton(
            onPressed: () {
              Dialogs.showTransactionFeedbackDialog(
                context,
                () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              );
            },
            child: const Text(
              'BACK TO HOME',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
  }
}
