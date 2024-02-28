import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/domain/entities/transfer/transfer_balance.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/image_handler.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/view/home_view.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';

import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class TransferSuccessPage extends ConsumerWidget {
  const TransferSuccessPage({super.key, required this.transferBalance});
  final TransferBalance transferBalance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cmsBody = ref.watch(cmsBodyStyleProvider);
    return Scaffold(
      backgroundColor: HexColor.fromHex(cmsBody?.appBackGroundColor),
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
              text:
                  SplashScreenNotifier.getLanguageLabel('Transfer Successful'),
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
                  builder: (context) => const HomeView(),
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
