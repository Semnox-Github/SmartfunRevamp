import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/custom_checkbox.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/buy_a_card/provider/buy_card/buy_card_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';

class FilterDrawer extends ConsumerWidget {
  const FilterDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<List<int>> filters = [];
    return Drawer(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              decoration: const BoxDecoration(
                color: CustomColors.customLigthBlue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const MulishText(
                    text: 'Filter',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.cancel_outlined,
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
                ),
              ),
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  [10, 50],
                  [51, 100],
                  [101, 200],
                  [201, 300],
                  [300]
                ].map((e) {
                  final text = e.length == 2 ? '\$${e[0]} - \$${e[1]}' : '\$${e[0]}+';
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
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
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: CustomButton(
              onTap: () {
                Scaffold.of(context).closeEndDrawer();
                ref.read(buyCardNotifier.notifier).filter(filters);
              },
              label: SplashScreenNotifier.getLanguageLabel('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }
}
