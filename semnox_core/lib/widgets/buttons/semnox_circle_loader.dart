import 'package:flutter/material.dart';

class SemnoxCircleLoader extends StatelessWidget {
  const SemnoxCircleLoader({Key? key, this.color}) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 15,
      height: 15,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        color: color ?? Colors.white,
      ),
    );
  }
}
