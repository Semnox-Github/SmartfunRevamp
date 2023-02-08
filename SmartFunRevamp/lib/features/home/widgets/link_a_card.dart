import 'package:flutter/material.dart';
import 'package:semnox/core/widgets/input_text_field.dart';

import '../../../colors/gradients.dart';


class LinkACard extends StatelessWidget {
  
  const LinkACard({super.key});
  

  @override
  Widget build(BuildContext context) {
    String mCardNumber = '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Add your card and manager your recharges,',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'activities, gameplays and more with smartfun.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 15.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            Expanded(
              child:  InputTextField(
                onSaved: (cardNumber) => mCardNumber = cardNumber,
                hintText: 'Enter Card Number',
                prefixIcon: IconButton(
                  icon: const Icon(
                    Icons.add_card,
                    color: Colors.black,
                  ), 
                  onPressed: () {  },
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: CustomGradients.linearGradient,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    gradient: CustomGradients.linearGradient,
                  ),
                  margin: const EdgeInsets.all(3),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'LINK CARD',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]
        )
      ],
    );
  }
}
