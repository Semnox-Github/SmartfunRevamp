import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/buy_card/card_product.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/payment/provider/payment_options_provider.dart';


class PaymentOptionsPage extends StatelessWidget {
  const PaymentOptionsPage({Key? key, required this.transactionResponse, required this.cardProduct}) : super(key: key);
  final EstimateTransactionResponse transactionResponse;
  final CardProduct cardProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFF8FF),
        elevation: 0.0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Payment Options',
          style: TextStyle(
            color: CustomColors.customBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recharge Value',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEEB2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${cardProduct.credits} play credit',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${cardProduct.finalPrice}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Consumer(
              builder: (context, ref, child) {
                return ref.watch(PaymentOptionsProvider.paymentModesProvider).maybeWhen(
                      orElse: () => Container(
                        height: 20.0,
                        width: 20.0,
                        color: Colors.red,
                      ),
                      error: (e,s) => Container(

                        child: MulishText(
                          text: '${e}',
                        ),
                      ),
                      loading: () => const CircularProgressIndicator(),
                      data: (data) {
                        return MulishText(
                          text: 'This user has ${data.length}  cards',
                        );
                      },
                    );
              },
            ),
            const SizedBox(height: 10.0),
           
            const Spacer(),
          ],
        ),
      ),
    );
  }

 
}
