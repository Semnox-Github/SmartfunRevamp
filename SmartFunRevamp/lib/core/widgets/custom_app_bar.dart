import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/widgets/mulish_text.dart';

import '../../features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import '../utils/extensions.dart';

final appHeader = Provider<CMSPageHeader?>((ref) {
  final cms = ref.watch(newHomePageCMSProvider);
  return cms?.cmsPageHeader;
});



class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.fontSize,
  }) : super(key: key);
  final String title;
  final double? fontSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headerStyle = ref.watch(appHeader);
    final backgroundColor = headerStyle?.backgroundColor;
    final textColor = headerStyle?.textColor;
    print("background Color $backgroundColor");
    print("textColor $textColor");
    return AppBar(
      title: MulishText(
        text: title,
        fontWeight: FontWeight.bold,
        fontColor: HexColor.fromHex(textColor), // CustomColors.customPink,
        //customBlue,

        fontSize: fontSize,
      ),
      iconTheme: IconThemeData(color: HexColor.fromHex(textColor)),
      centerTitle: false,
      backgroundColor: HexColor.fromHex(backgroundColor),
      toolbarHeight: kToolbarHeight,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarCustomWidget extends ConsumerWidget
    implements PreferredSizeWidget {
  const CustomAppBarCustomWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final Widget title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      elevation: 0.0,
      iconTheme: const IconThemeData(color: CustomColors.customBlue),
      backgroundColor: CustomColors.customBlack, //customLigthBlue,
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
