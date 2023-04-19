import 'package:flutter/material.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/pages/home_page.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({Key? key, this.cardNumber, required this.amount}) : super(key: key);
  final String? cardNumber;
  final double amount;
  @override
  Widget build(BuildContext context) {
    final String fixedAmount = amount.toStringAsFixed(2);
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
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          ),
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