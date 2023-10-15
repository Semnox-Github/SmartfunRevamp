import 'package:flutter/material.dart';
import 'package:semnox/core/domain/entities/transfer/transfer_balance.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/image_handler.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/pages/home_page.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class TransferSuccessPage extends StatelessWidget {
  const TransferSuccessPage({super.key, required this.transferBalance});
  final TransferBalance transferBalance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 54.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            ImageHandler(
              height: MediaQuery.of(context).size.height * 0.3,
              imageKey: "transfer_success_image_path",
            ),
            MulishText(
              textAlign: TextAlign.center,
              text: SplashScreenNotifier.getLanguageLabel('Transfer Successful'),
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            MulishText(
              textAlign: TextAlign.center,
              text:
                  'You have successfully transfered ${transferBalance.amount} ${transferBalance.entitlement} to card number ${transferBalance.to.accountNumber}',
              fontSize: 16.0,
            ),
            const Spacer(),
            CustomButton(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              ),
              label: SplashScreenNotifier.getLanguageLabel('DONE'),
            ),
          ],
        ),
      ),
    );
  }
}
