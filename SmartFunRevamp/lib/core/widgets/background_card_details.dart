import 'package:flutter/material.dart';
import 'package:semnox/colors/gradients.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard({
    Key? key, 
    required this.child,
    required this.isBlocked
  }) : super(key: key);
  final Widget child;
  final bool isBlocked;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children:[
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: isBlocked ? Colors.purple.shade400.withOpacity(0.5): Colors.purple.shade400,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: child,
        ),
        if (isBlocked)
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
                    text: 'BLOCKED',
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
