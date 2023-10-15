import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({
    super.key,
    required this.iconPath,
    required this.iconBgColor,
    required this.onTap,
    this.title,
    required this.desc,
    required this.item,
  });
  final String iconPath;
  final Color iconBgColor;
  final Function()? onTap;
  final String? title;
  final String desc;
  final CMSMenuItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${item.displayName} not implemented yet'),
              ),
            );
          },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: CustomColors.customLigthGray,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: item.itemUrl,
                height: 36,
                width: 36,
                placeholder: (context, url) => const CircularProgressIndicator.adaptive(),
                //this image ('gold_medal') looks like a placeholder for this error widget
                errorWidget: (context, url, error) => Image.asset(
                  'assets/home/$iconPath.png',
                  height: 36.0,
                  width: 36.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MulishText(
                  text: SplashScreenNotifier.getLanguageLabel(title ?? item.displayName),
                  fontWeight: FontWeight.bold,
                  fontColor: CustomColors.customPantone,
                  fontSize: 16.0,
                ),
                MulishText(
                  text: desc,
                  fontColor: CustomColors.customPantone,
                  fontSize: 12,
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
            // IconButton(
            //   onPressed: onTap ??
            //       () {
            //         ScaffoldMessenger.of(context).clearSnackBars();
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(
            //             content: Text('${item.displayName} not implemented yet'),
            //           ),
            //         );
            //       },
            //   icon: const Icon(Icons.arrow_forward_ios),
            // ),
          ],
        ),
      ),
    );
  }
}
