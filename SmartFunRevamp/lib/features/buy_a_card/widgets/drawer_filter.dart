import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/custom_checkbox.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/buy_a_card/provider/buy_card/buy_card_notifier.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class FilterDrawer extends ConsumerWidget {
  const FilterDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cmsHeader = ref.watch(cmsPageHeaderProvider);
    final cmsBody = ref.watch(cmsBodyStyleProvider);
    List<List<int>>? buyACardFilters =
        ref.watch(newHomePageCMSProvider)?.buyACardFilters;
    List<List<int>> gFilter = buyACardFilters ??
        [
          [0]
        ];

    List<List<int>> filters = [];
    return Drawer(
      backgroundColor: HexColor.fromHex(cmsBody?.appBackGroundColor),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: HexColor.fromHex(cmsHeader?.backgroundColor),
                //CustomColors.customLigthBlue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    SplashScreenNotifier.getLanguageLabel('Filter'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: HexColor.fromHex(cmsHeader?.textColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: HexColor.fromHex(cmsHeader?.textColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                SplashScreenNotifier.getLanguageLabel('Price Range'),
                style: GoogleFonts.mulish(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: HexColor.fromHex(cmsBody?.appTextColor)),
              ),
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: gFilter.map((e) {
                  final text =
                      e.length == 2 ? '\$${e[0]} - \$${e[1]}' : '\$${e[0]}+';
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    // textColor: HexColor.fromHex(cmsBody?.appTextColor),
                    leading: CustomCheckBox(
                      onTap: (isChecked) {
                        if (isChecked) {
                          filters.add(e);
                        } else {
                          filters.remove(e);
                        }
                      },
                    ),
                    title: Text(
                      text,
                      style: TextStyle(
                          color: HexColor.fromHex(cmsBody?.appTextColor)),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: CustomButton(
              onTap: () {
                Scaffold.of(context).closeEndDrawer();
                ref.read(filterProvider.notifier).update((_) => filters);
              },
              label: SplashScreenNotifier.getLanguageLabel('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }
}
