import 'package:flutter/material.dart';
import 'package:semnox/colors/gradients.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({Key? key}) : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      height: 25.0,
      width: 25.0,
      decoration: BoxDecoration(
        gradient: CustomGradients.linearGradient,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          child: isChecked
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 15.0,
                )
              : Container(
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
          },
        ),
      ),
      // child: IconButton(
      //   iconSize: 15.0,
      //   padding: EdgeInsets.zero,
      //   icon: const Icon(
      //     Icons.check,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {
      //     setState(() {
      //       isChecked = !isChecked;
      //     });
      //   },
      // ),
    );
  }
}
