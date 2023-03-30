import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/core/utils/extensions.dart';

class BlockedCardWidget extends StatelessWidget {
  BlockedCardWidget({Key? key, required this.cardDetails}) : super(key: key);

  final formatter = DateFormat('dd MMM yyyy');
  final CardDetails cardDetails;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [ 
        Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.only(left: 15, top: 0, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: CustomGradients.linearGradient,
            color: Colors.white.withOpacity(0.5),
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
                          fontSize: 20,
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
                                text: '',
                                textDecoration: TextDecoration.underline,
                                fontColor: Colors.white,
                              ),
                      ]),
                    ],
                  ),
                  Image.asset(
                    'assets/home/QR.png',
                    height: 42,
                  )
                ],
              ),
              const SizedBox(height: 10.0),
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
              const SizedBox(height: 10.0),
              MulishText(
                text: '${formatter.format(cardDetails.issueDate ?? DateTime.now())} -${formatter.format(DateTime.parse(cardDetails.expiryDate.toString()))}',
                fontColor: Colors.white,
              )
            ],
          ),
        ),
        Container(
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
                text: 'BLOCKED',
                fontColor: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )
            ],
          ),
        )
      ]
    );
  }
}
