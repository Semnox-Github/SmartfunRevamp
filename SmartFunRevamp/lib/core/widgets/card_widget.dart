import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/image_handler.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class CardWidget extends StatelessWidget {
  CardWidget({Key? key, required this.cardDetails}) : super(key: key);

  final formatter = DateFormat('dd MMM yyyy');
  late final CardDetails cardDetails;
  late final validPeriod = cardDetails.expiryDate.isNullOrEmpty()
      ? formatter.format(cardDetails.issueDate ?? DateTime.now())
      : '${formatter.format(cardDetails.issueDate ?? DateTime.now())} - ${formatter.format(DateTime.parse(cardDetails.expiryDate.toString()))}';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.only(left: 15, top: 0, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: CustomGradients.linearGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    cardDetails.accountNumber ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 7.0),
                  Text(
                    '+${SplashScreenNotifier.getLanguageLabel('Add nickname')}',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Dialogs.showBarcodeTempCard(context, cardDetails.accountNumber ?? ''),
                child: const ImageHandler(
                  height: 42.0,
                  imageKey: "QR_image_path",
                ),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            validPeriod,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              const ImageHandler(
                height: 32,
                imageKey: "coin_image_path",
              ),
              Text(
                '  \$ ${cardDetails.creditPlusCardBalance!.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          MulishText(
            text: validPeriod,
            fontColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
