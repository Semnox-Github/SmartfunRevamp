import 'package:flutter/material.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class PaymentFailedPage extends StatelessWidget {
  const PaymentFailedPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/payment/payment_failed.png',
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  const SizedBox(height: 10.0),
                  const MulishText(
                    textAlign: TextAlign.center,
                    text: 'Payment Failed',
                    fontColor: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                  const MulishText(
                    textAlign: TextAlign.center,
                    text: 'Oops! We were unable to process your payment at the moment. Any money deducted from your account will be reverted back to the source of payment in 3-5 working days.',
                    fontColor: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: CustomGradients.linearGradient,
                ),
                margin: const EdgeInsets.all(3),
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    SplashScreenNotifier.getLanguageLabel('RETRY PAYMENT'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
