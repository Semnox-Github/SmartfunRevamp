import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.fontSize,
  }) : super(key: key);
  final String title;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: MulishText(
        text: title,
        fontWeight: FontWeight.bold,
        fontColor: CustomColors.customBlue,
        fontSize: fontSize,
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}

class CustomAppBarCustomWidget extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarCustomWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      iconTheme: const IconThemeData(color: CustomColors.customBlue),
      backgroundColor: CustomColors.customLigthBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      title: title,
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
