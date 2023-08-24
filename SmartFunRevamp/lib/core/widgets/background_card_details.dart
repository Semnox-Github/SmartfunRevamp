import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';

import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';

Color _cardColor(bool isVirtual, bool isExpired, CardsColor? colors) {
  if (isExpired) {
    return HexColor.fromHex(colors?.expired) ?? Colors.grey;
  }
  if (isVirtual) {
    return HexColor.fromHex(colors?.virtual) ?? Colors.pink;
  }
  return HexColor.fromHex(colors?.regular) ?? Colors.purple;
}

class BackgroundCard extends ConsumerWidget {
  const BackgroundCard({
    Key? key,
    required this.child,
    required this.isVirtual,
    required this.cardNumber,
    required this.isExpired,
  }) : super(key: key);
  final Widget child;
  final bool isVirtual;
  final String cardNumber;
  final bool isExpired;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardColors = ref.watch(newHomePageCMSProvider)?.cardsColor;
    return Stack(alignment: AlignmentDirectional.center, children: [
      GestureDetector(
        onTap: !isVirtual ? () {} : () => Dialogs.showBarcodeTempCard(context, cardNumber),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: _cardColor(isVirtual, isExpired, cardColors),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: child,
        ),
      ),
      if (isExpired)
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: const Color(0xFF545454).withOpacity(0.7),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      if (isVirtual)
        Center(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/lost_card/blocked.png',
                  height: 70,
                ),
                const SizedBox(height: 10.0),
                const MulishText(
                  text: 'VIRTUAL',
                  fontColor: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )
              ],
            ),
          ),
        )
      else if (isExpired)
        Center(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/expired_card/expired.png',
                  height: 70,
                ),
                const SizedBox(height: 10.0),
                const MulishText(
                  text: 'EXPIRED',
                  fontColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )
              ],
            ),
          ),
        )
    ]);
  }
}
