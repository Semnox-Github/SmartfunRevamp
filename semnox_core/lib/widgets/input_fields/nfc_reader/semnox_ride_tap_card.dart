import 'package:flutter/material.dart';
import 'package:semnox_core/generator/assets.generator.dart';
import 'package:semnox_core/semnox_core.dart';

class SemnoxRideTapCard extends StatelessWidget {
  final String title;
  final bool disableShadow;
  final bool enableQrScan;
  const SemnoxRideTapCard({
    Key? key,
    required this.title,
    this.disableShadow = false,
    required this.enableQrScan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SemnoxFlatCard(
      color: SemnoxConstantColor.cardForeground(context), //Colors.white,
      // disableShadow: disableShadow,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(16.mapToIdealWidth(context)),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              SemnoxText.h5(text: title),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(32.mapToIdealWidth(context)),
            child: Container(
              padding: SemnoxPadding.largePadding(context),
              height: 200.mapToIdealWidth(context),
              width: 200.mapToIdealWidth(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(
                //   324.mapToIdealWidth(context),
                // ),
                color: SemnoxConstantColor.lightPrimaryColor(context),
              ),
              alignment: Alignment.bottomRight,
              child: Image.asset(
                "${enableQrScan ? Assets.gif.debitCardQrcodeAnimation.path : Assets.gif.defaultDebitCardTapAnimation.path}",
                fit: BoxFit.cover,
                package: "semnox_core",
              ),
            ),
          )
        ],
      ),
    );
  }
}
