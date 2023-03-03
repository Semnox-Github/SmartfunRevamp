import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class VirtualCardWidget extends StatelessWidget {
  VirtualCardWidget({Key? key, required this.cardDetails}) : super(key: key);

  final formatter = DateFormat('dd MMM yyyy');
  final CardDetails cardDetails;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [ 
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: CustomGradients.linearGradient,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MulishText(
                text: cardDetails.accountNumber ?? '',
                fontColor: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              const SizedBox(height: 10.0),
              const MulishText(
                text: '+Add Nickname',
                fontColor: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,  
                    children:  [
                      const MulishText(
                        text: '1000',
                        fontColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      const SizedBox(height: 10.0),
                      MulishText(
                        text: '${formatter.format(cardDetails.issueDate ?? DateTime.now())} -${formatter.format(cardDetails.expiryDate ?? DateTime.now())}',
                        fontColor: Colors.white,
                      )
                    ]  
                  ),
                  Image.asset(
                    'assets/home/QR.png',
                    height: 60,
                  )
                ],
              ), 
            ],
          ),
        ),
      ]
    );
  }
}
