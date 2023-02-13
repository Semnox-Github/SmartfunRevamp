import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class BuyNewCardButton extends StatelessWidget {
  const BuyNewCardButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: CustomGradients.linearGradient,
      ),
      margin: const EdgeInsets.all(3),
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/home/card_add.svg'),
            const SizedBox(width: 5.0),
            const MulishText(
              text: 'BUY A NEW CARD',
              fontColor: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
