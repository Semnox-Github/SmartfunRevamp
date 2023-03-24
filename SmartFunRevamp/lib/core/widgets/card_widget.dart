import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/core/utils/extensions.dart';

class CardWidget extends StatelessWidget {
  CardWidget({Key? key, required this.cardDetails}) : super(key: key);

  final formatter = DateFormat('dd MMM yyyy');
  final CardDetails cardDetails;
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    MulishText(
                      text: cardDetails.accountNumber ?? '',
                      fontColor: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ]),
                  const SizedBox(width: 10.0),
                  Row(children: [
                    !cardDetails.accountIdentifier.isNullOrEmpty()
                        ? MulishText(
                            text: cardDetails.accountIdentifier ?? '',
                            fontColor: Colors.white,
                          )
                        : const MulishText(
                            text: '+Add Nickname',
                            textDecoration: TextDecoration.underline,
                            fontColor: Colors.white,
                          ),
                  ]),
                ],
              ),
              GestureDetector(
                onTap: () => Dialogs.showBarcodeTempCard(context, cardDetails.accountNumber!),
                child: Image.asset(
                  'assets/home/QR.png',
                  height: 42,
                ),
              )
            ],
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              side: const BorderSide(
                width: 1.5,
                color: Colors.white,
              ),
            ),
            child: const MulishText(
              text: 'Get Balance',
              fontColor: Colors.white,
            ),
          ),
          MulishText(
            text: '${formatter.format(cardDetails.issueDate ?? DateTime.now())} -${formatter.format(cardDetails.expiryDate ?? DateTime.now())}',
            fontColor: Colors.white,
          )
        ],
      ),
    );
  }
}
