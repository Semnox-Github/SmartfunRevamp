import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

import '../../../core/domain/entities/splash_screen/home_page_cms_response.dart';
import '../../../core/routes.dart';
import '../../splash/provider/new_splash_screen/new_splash_screen_notifier.dart';

final primaryButtonStyle = Provider<PrimaryButtonStyle?>((ref) {
  final cms = ref.watch(newHomePageCMSProvider);
  return cms?.buttonStyle?.primaryButtonStyle;
});

class BuyNewCardButton extends ConsumerWidget {
  const BuyNewCardButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonStyle = ref.watch(primaryButtonStyle);
    final btnGradient = buttonStyle?.buttonColorGradient.getColorList();
    final btnTextColor = buttonStyle?.buttonTextColor;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient:
            btnGradient != null ? LinearGradient(colors: btnGradient) : null,
      ),
      margin: const EdgeInsets.all(3),
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, Routes.kBuyACard),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/home/card_add.svg'),
            const SizedBox(width: 5.0),
            MulishText(
              text: 'BUY A NEW CARD',
              fontColor: HexColor.fromHex(btnTextColor),
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
