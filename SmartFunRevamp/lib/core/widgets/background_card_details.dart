import 'package:flutter/material.dart';

import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class BackgroundCard extends StatelessWidget {
   const BackgroundCard({
    Key? key, 
    required this.child,
    required this.isVirtual,
    required this.cardNumber,
  }) : super(key: key);
  final Widget child;
  final bool isVirtual;
  final String cardNumber;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children:[
        GestureDetector(
          onTap: !isVirtual ? () {} : () => Dialogs.showBarcodeTempCard(context, cardNumber),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: isVirtual ? Colors.purple.shade400.withOpacity(0.5): Colors.purple.shade400,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: child,
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
      ]
    );    
  }
}